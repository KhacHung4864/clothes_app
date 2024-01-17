import 'dart:convert';

import 'package:clothes_app/constants/app_url.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/order/order_detail/order_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderDetailScreen extends GetView<OrderDetailController> {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          DateFormat("dd MMMM, yyyy - hh:mm a").format(controller.orderItem.dateTime!),
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          controller.isAdmin
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                  child: Material(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        if (controller.orderItem.status?.value == 0) {
                          showDialogForParcelConfirmation();
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: Row(
                          children: [
                            const Text(
                              "Received",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Obx(
                              () => controller.orderItem.status?.value == 0
                                  ? const Icon(
                                      Icons.help_outline,
                                      color: Colors.redAccent,
                                    )
                                  : const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.greenAccent,
                                    ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //display items belongs to clicked order
              displayClickedOrderItems(),

              const SizedBox(
                height: 16,
              ),

              //phoneNumber
              showTitleText("Phone Number:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.phoneNumber!),

              const SizedBox(
                height: 26,
              ),

              //Shipment Address
              showTitleText("Shipment Address:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.shipmentAddress!),

              const SizedBox(
                height: 26,
              ),

              //delivery
              showTitleText("Delivery System:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.deliverySystem!),

              const SizedBox(
                height: 26,
              ),

              //payment
              showTitleText("Payment System:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.paymentSystem!),

              const SizedBox(
                height: 26,
              ),

              //note
              showTitleText("Note to Seller:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.note!),

              const SizedBox(
                height: 26,
              ),

              //total amount
              showTitleText("Total Amount:"),
              const SizedBox(
                height: 8,
              ),
              showContentText(controller.orderItem.totalAmount.toString()),

              const SizedBox(
                height: 26,
              ),

              //payment proof
              showTitleText("Proof of Payment/Transaction:"),
              const SizedBox(
                height: 8,
              ),
              FadeInImage(
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.fitWidth,
                placeholder: Assets.images.placeHolder.provider(),
                image: NetworkImage(
                  AppUrl.hostImages + controller.orderItem.image!,
                ),
                imageErrorBuilder: (context, error, stackTraceError) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image_outlined,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogForParcelConfirmation() async {
    if (controller.orderItem.status?.value == 0) {
      var response = await Get.dialog(
        AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "Confirmation",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          content: const Text(
            "Have you received your parcel?",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.redAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back(result: "yesConfirmed");
              },
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      );

      if (response == "yesConfirmed") {
        controller.updateStatusValueInDatabase();
      }
    }
  }

  Widget showTitleText(String titleText) {
    return Text(
      titleText,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.grey,
      ),
    );
  }

  Widget showContentText(String contentText) {
    return Text(
      contentText,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.white38,
      ),
    );
  }

  Widget displayClickedOrderItems() {
    List<String> clickedOrderItemsInfo = controller.orderItem.selectedItems!.split("||");

    return Column(
      children: List.generate(clickedOrderItemsInfo.length, (index) {
        Map<String, dynamic> itemInfo = jsonDecode(clickedOrderItemsInfo[index]);

        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 8,
            16,
            index == clickedOrderItemsInfo.length - 1 ? 16 : 8,
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
                  image: NetworkImage(
                    itemInfo["image"],
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
                        itemInfo["name"] ?? "",
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
                        itemInfo["size"].replaceAll("[", "").replaceAll("]", "") + "\n" + itemInfo["color"].replaceAll("[", "").replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white54,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Text(
                        "\$ ${itemInfo["price"] * itemInfo["quantity"]}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.purpleAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "${itemInfo["price"]} x ${itemInfo["quantity"]} = ${itemInfo["price"] * itemInfo["quantity"]}",
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
                  "Q: ${itemInfo["quantity"]}",
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
}
