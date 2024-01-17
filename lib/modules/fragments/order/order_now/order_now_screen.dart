import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/order/order_now/oder_now_controller.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderNowScreen extends GetView<OrderNowController> {
  const OrderNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Order Now"),
        titleSpacing: 0,
      ),
      body: ListView(
        children: [
          displaySelectedItemsFromUserCart(),
          const SizedBox(height: 30),

          //delivery system
          titleText('Delivery System:'),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: controller.deliverySystemNamesList.map((deliverySystemName) {
                return Obx(() => RadioListTile<String>(
                      tileColor: Colors.white24,
                      dense: true,
                      activeColor: Colors.purpleAccent,
                      title: Text(
                        deliverySystemName,
                        style: const TextStyle(fontSize: 16, color: Colors.white38),
                      ),
                      value: deliverySystemName,
                      groupValue: controller.deliverySystem.value,
                      onChanged: (newDeliverySystemValue) {
                        controller.deliverySystem.value = newDeliverySystemValue!;
                      },
                    ));
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          //payment system
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Payment System:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Company Account Number / ID: \nY87Y-HJF9-CVBN-4321',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: controller.paymentSystemNamesList.map((paymentSystemName) {
                return Obx(() => RadioListTile<String>(
                      tileColor: Colors.white24,
                      dense: true,
                      activeColor: Colors.purpleAccent,
                      title: Text(
                        paymentSystemName,
                        style: const TextStyle(fontSize: 16, color: Colors.white38),
                      ),
                      value: paymentSystemName,
                      groupValue: controller.paymentSystem.value,
                      onChanged: (newPaymentSystemValue) {
                        controller.paymentSystem.value = newPaymentSystemValue!;
                      },
                    ));
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          //phone number
          titleText('Phone Number:'),
          textFormfield(controller.phoneNumberController, 'any Contact Number..'),
          const SizedBox(height: 16),

          //shipment address
          titleText('Shipment Address:'),
          textFormfield(controller.shipmentAddressController, 'your Shipment Address..'),
          const SizedBox(height: 16),

          //note to seller
          titleText('Note to Seller:'),
          textFormfield(controller.noteToSellerController, 'Any note you want to write to seller..'),
          const SizedBox(height: 30),

          //pay amount now btn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  if (controller.phoneNumberController.text.isNotEmpty && controller.shipmentAddressController.text.isNotEmpty) {
                    Get.toNamed(Routes.orderConfirmation);
                  } else {
                    Fluttertoast.cancel();
                    Fluttertoast.showToast(msg: "Please complete the form.");
                  }
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "\$${controller.totalAmount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Pay Amount Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  displaySelectedItemsFromUserCart() {
    return Column(
      children: List.generate(controller.selectedCartListItemsInfo.length, (index) {
        CartData eachSelectedItem = controller.selectedCartListItemsInfo[index];

        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 8,
            16,
            index == controller.selectedCartListItemsInfo.length - 1 ? 16 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white24,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              //image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FadeInImage(
                  height: 150,
                  width: 130,
                  fit: BoxFit.cover,
                  placeholder: Assets.images.placeHolder.provider(),
                  image: NetworkImage(eachSelectedItem.image ?? ''),
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

              //name
              //size
              //price
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      Text(
                        eachSelectedItem.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //size + color
                      Text(
                        "${eachSelectedItem.size!.replaceAll("[", "").replaceAll("]", "")}\n${eachSelectedItem.color!.replaceAll("[", "").replaceAll("]", "")}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Text(
                        "\$ ${eachSelectedItem.quantity! * eachSelectedItem.price!}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "${eachSelectedItem.price} x ${eachSelectedItem.quantity} = ${eachSelectedItem.quantity! * eachSelectedItem.price!}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //quantity
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Q: ${eachSelectedItem.quantity}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Padding textFormfield(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        style: const TextStyle(color: Colors.white54),
        controller: controller,
        decoration: InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(
            color: Colors.white24,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.white24,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  Padding titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white70,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
