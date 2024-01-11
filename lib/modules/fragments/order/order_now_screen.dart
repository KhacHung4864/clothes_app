import 'package:clothes_app/modules/fragments/order/oder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderNowScreen extends GetView<OrderController> {
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
                  // if (phoneNumberController.text.isNotEmpty && shipmentAddressController.text.isNotEmpty) {
                  //   Get.to(OrderConfirmationScreen(
                  //     selectedCartIDs: selectedCartIDs,
                  //     selectedCartListItemsInfo: selectedCartListItemsInfo,
                  //     totalAmount: totalAmount,
                  //     deliverySystem: controller.deliverySys,
                  //     paymentSystem: controller.paymentSys,
                  //     phoneNumber: phoneNumberController.text,
                  //     shipmentAddress: shipmentAddressController.text,
                  //     note: noteToSellerController.text,
                  //   ));
                  // } else {
                  //   Fluttertoast.showToast(msg: "Please complete the form.");
                  // }
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
