import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/order/order_confirmation/order_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OrderConfirmationScreen extends GetView<OrderConfirmationController> {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Order Confirmation"),
        titleSpacing: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //image
            Assets.images.transaction.image(width: 160.w),

            const SizedBox(
              height: 4,
            ),

            //title
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Please Attach Transaction \nProof Screenshot / Image",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //select image btn
            Material(
              elevation: 8,
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  controller.chooseImageFromGallery();
                },
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            //display selected image by user
            Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    maxHeight: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: controller.imageSelectedByte.isNotEmpty
                      ? Image.memory(
                          controller.imageSelectedByte,
                          fit: BoxFit.contain,
                        )
                      : const Placeholder(
                          color: Colors.white60,
                        ),
                )),

            const SizedBox(height: 16),

            //confirm and proceed
            Obx(() => Material(
                  elevation: 8,
                  color: controller.imageSelectedByte.isNotEmpty ? Colors.purpleAccent : Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      if (controller.imageSelectedByte.isNotEmpty) {
                        //save order info
                        controller.saveNewOrderInfo();
                      } else {
                        Fluttertoast.showToast(msg: "Please attach the transaction proof / screenshot.");
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        "Confirmed & Proceed",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
