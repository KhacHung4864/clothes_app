import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/cart/cart_controller.dart';
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
          () => controller.cartList.isEmpty && !controller.isLoading.value
              ? Center(
                  child: Text(
                    'Cart is Empty',
                    style: AppFont.t.grey.s(15),
                  ),
                )
              : ListView.builder(
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
        ));
  }

  GestureDetector cartItem(int index) {
    return GestureDetector(
      onTap: () {},
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
