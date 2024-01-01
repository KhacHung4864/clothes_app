import 'package:clothes_app/data/local/app_storage.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Get.putAsync(() => AppStorage().sharedPreferences());
  }
}
