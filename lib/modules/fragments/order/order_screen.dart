import 'package:clothes_app/modules/fragments/order/oder_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class OrderScreen extends GetView<OderController> {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Oder')),
    );
  }
}
