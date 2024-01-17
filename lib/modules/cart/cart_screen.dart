import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/cart/cart_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("My Cart"),
          actions: [
            //to select all items
            Obx(
              () => controller.cartList.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.setIsSelectedAll();
                        controller.clearAllSelectedItem();

                        if (controller.isSelectedAll.value) {
                          for (var eachItem in controller.cartList) {
                            controller.addSelectedItem(eachItem.cartId!);
                          }
                        }

                        controller.calculateTotalAmount();
                      },
                      icon: Icon(
                        controller.isSelectedAll.value ? Icons.check_box : Icons.check_box_outline_blank,
                        color: controller.isSelectedAll.value ? Colors.white : Colors.grey,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),

            //to delete selected item/items
            Obx(
              () => controller.cartList.isNotEmpty && controller.selectedItemList.isNotEmpty
                  ? IconButton(
                      onPressed: () async {
                        var responseFromDialogBox = await Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.grey,
                            title: const Text("Delete"),
                            content: const Text("Are you sure to Delete selected items from your Cart List?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const Text(
                                  "No",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back(result: "yesDelete");
                                },
                                child: const Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (responseFromDialogBox == "yesDelete") {
                          for (var selectedItemUserCartID in controller.selectedItemList) {
                            //  delete selected items now
                            controller.deleteSelectedItemsFromUserCartList(selectedItemUserCartID);
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.delete_sweep,
                        size: 26,
                        color: Colors.redAccent,
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.cartList.isEmpty && !controller.isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Text(
                        'Cart is Empty',
                        style: AppFont.t.grey.s(15),
                      ),
                    )
                  : const SizedBox.shrink(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getCartList();
                  },
                  child: ListView.builder(
                    itemCount: controller.cartList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            //check box
                            GetBuilder(
                              init: controller,
                              builder: (controller) {
                                return IconButton(
                                  onPressed: () {
                                    if (controller.selectedItemList.contains(controller.cartList[index].cartId)) {
                                      controller.deleteSelectedItem(controller.cartList[index].cartId!);
                                    } else {
                                      controller.addSelectedItem(controller.cartList[index].cartId!);
                                    }
                                    controller.calculateTotalAmount();
                                  },
                                  icon: Icon(
                                    controller.selectedItemList.contains(controller.cartList[index].cartId) ? Icons.check_box : Icons.check_box_outline_blank,
                                    color: controller.isSelectedAll.value ? Colors.white : Colors.grey,
                                  ),
                                );
                              },
                            ),

                            //name
                            //color size + price
                            //+ 2 -
                            //image
                            Expanded(
                              child: cartItem(index),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -3),
                  color: Colors.white24,
                  blurRadius: 6,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                //total amount
                const Text(
                  "Total Amount:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Obx(
                  () => Text(
                    "\$ ${controller.total.toStringAsFixed(2)}",
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Spacer(),

                //order now btn
                Material(
                  color: controller.selectedItemList.isNotEmpty ? Colors.purpleAccent : Colors.white24,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      if (controller.selectedItemList.isNotEmpty) {
                        Get.toNamed(Routes.orderNow);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        "Order Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  GestureDetector cartItem(int index) {
    return GestureDetector(
      onTap: () {
        for (var element in controller.homeController.listAllClothItems) {
          if (element.itemId == controller.cartList[index].itemId) {
            Get.toNamed(Routes.itemDetails, arguments: element);
          }
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(
          0,
          index == 0 ? 16 : 8,
          16,
          index == controller.cartList.length - 1 ? 16 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 6,
              color: Colors.white,
            ),
          ],
        ),
        child: Row(
          children: [
            //name
            //color size + price
            //+ 2 -
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    Text(
                      controller.cartList[index].name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    //color size + price
                    Row(
                      children: [
                        //color size
                        Expanded(
                          child: Text(
                            "Color: ${controller.cartList[index].color!.replaceAll('[', '').replaceAll(']', '')}\nSize: ${controller.cartList[index].size!.replaceAll('[', '').replaceAll(']', '')}",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white60,
                            ),
                          ),
                        ),

                        //price
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12.0),
                          child: Text(
                            "\$${controller.cartList[index].price}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //+ 2 -
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //-
                        IconButton(
                          onPressed: () {
                            if (controller.cartList[index].quantity! - 1 >= 1) {
                              controller.updateQuantityInUserCart(
                                controller.cartList[index].cartId!,
                                controller.cartList[index].quantity! - 1,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        Text(
                          controller.cartList[index].quantity.toString(),
                          style: const TextStyle(
                            color: Colors.purpleAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          width: 10,
                        ),

                        //+
                        IconButton(
                          onPressed: () {
                            controller.updateQuantityInUserCart(
                              controller.cartList[index].cartId!,
                              controller.cartList[index].quantity! + 1,
                            );
                          },
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //item image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(22),
                bottomRight: Radius.circular(22),
              ),
              child: FadeInImage(
                height: 185,
                width: 150,
                fit: BoxFit.cover,
                placeholder: Assets.images.placeHolder.provider(),
                image: NetworkImage(controller.cartList[index].image ?? ''),
                imageErrorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                      color: Palette.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
