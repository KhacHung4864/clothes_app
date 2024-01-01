import 'package:clothes_app/modules/cart/cart_controller.dart';
import 'package:get/get.dart';

import '../item/item_details_controller.dart';
import 'dashboard_fragments_controller.dart';
import 'favorites/favorites_controller.dart';
import 'home/home_controller.dart';
import 'order/oder_controller.dart';
import 'profile/proflile_controller.dart';

class DashboardFragmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardFragmentsController());

    //Home
    Get.put(HomeController());

    //Favorites
    Get.lazyPut<FavoritesController>(() => FavoritesController());

    //Oder
    Get.lazyPut<OderController>(() => OderController());

    //Profile
    Get.lazyPut<ProfileController>(() => ProfileController());

    //Item Detail

    Get.lazyPut<ItemDetailController>(() => ItemDetailController());

    //Cart
    Get.lazyPut<CartController>(() => CartController());
    // Get.put(CartController());
  }
}
