import 'package:clothes_app/modules/admin/order/order_admin_controller.dart';
import 'package:get/get.dart';

class OrderAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OrderAdminController());
  }
}
