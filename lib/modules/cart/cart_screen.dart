import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
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
              () => IconButton(
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
              ),
            ),

            //to delete selected item/items
            GetBuilder(
                init: controller,
                builder: (c) {
                  if (controller.selectedItemList.isNotEmpty) {
                    return IconButton(
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
                            // controller.deleteSelectedItemsFromUserCartList(selectedItemUserCartID);
                          }
                        }

                        controller.calculateTotalAmount();
                      },
                      icon: const Icon(
                        Icons.delete_sweep,
                        size: 26,
                        color: Colors.redAccent,
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ],
        ),
        body: Obx(
          () => controller.cartList.isEmpty
              ? const Center(
                  child: Text('Cart is Empty'),
                )
              : ListView.builder(
                  itemCount: controller.cartList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    CartData cartModel = controller.cartList[index];

                    ClothItem clothesModel = ClothItem(
                      itemId: cartModel.itemId,
                      colors: cartModel.colors,
                      image: cartModel.image,
                      name: cartModel.name,
                      price: cartModel.price,
                      rating: cartModel.rating,
                      sizes: cartModel.sizes,
                      description: cartModel.description,
                      tags: cartModel.tags,
                    );
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          //check box
                          GetBuilder(
                            init: controller,
                            builder: (c) {
                              return IconButton(
                                onPressed: () {
                                  if (controller.selectedItemList.contains(cartModel.cartId)) {
                                    controller.deleteSelectedItem(cartModel.cartId!);
                                  } else {
                                    controller.addSelectedItem(cartModel.cartId!);
                                  }

                                  controller.calculateTotalAmount();
                                },
                                icon: Icon(
                                  controller.selectedItemList.contains(cartModel.cartId) ? Icons.check_box : Icons.check_box_outline_blank,
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
                            child: GestureDetector(
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
                                              clothesModel.name.toString(),
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
                                                    "Color: ${cartModel.color!.replaceAll('[', '').replaceAll(']', '')}\nSize: ${cartModel.size!.replaceAll('[', '').replaceAll(']', '')}",
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
                                                    "\$${clothesModel.price}",
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
                                                    if (cartModel.quantity! - 1 >= 1) {
                                                      //  controller. updateQuantityInUserCart(
                                                      //     cartModel.cart_id!,
                                                      //     cartModel.quantity! - 1,
                                                      //   );
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
                                                  cartModel.quantity.toString(),
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
                                                    // updateQuantityInUserCart(
                                                    //   cartModel.cart_id!,
                                                    //   cartModel.quantity! + 1,
                                                    // );
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
                                        placeholder: const AssetImage("images/place_holder.png"),
                                        image: NetworkImage(
                                          cartModel.image ?? '',
                                        ),
                                        imageErrorBuilder: (context, error, stackTraceError) {
                                          return const Center(
                                            child: Icon(
                                              Icons.broken_image_outlined,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ));
  }
}
