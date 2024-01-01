import 'package:clothes_app/modules/admin/upload/upload_items_controller.dart';
import 'package:get/get.dart';

class AdminUploadItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AdminUploadItemsController());
  }
}
