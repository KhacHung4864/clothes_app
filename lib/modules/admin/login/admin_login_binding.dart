import 'package:clothes_app/modules/admin/login/admin_login_controller.dart';
import 'package:get/get.dart';

class AdminLoginBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminLoginController());
  }
}
