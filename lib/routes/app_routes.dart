import 'package:clothes_app/modules/admin/login/admin_login_binding.dart';
import 'package:clothes_app/modules/admin/login/admin_login_screen.dart';
import 'package:clothes_app/modules/admin/order/order_admin_binding.dart';
import 'package:clothes_app/modules/admin/order/order_admin_screen.dart';
import 'package:clothes_app/modules/admin/upload/upload_items_binding.dart';
import 'package:clothes_app/modules/admin/upload/upload_items_screen.dart';
import 'package:clothes_app/modules/authentication/login/login_binding.dart';
import 'package:clothes_app/modules/authentication/login/login_screen.dart';
import 'package:clothes_app/modules/authentication/signup/signup_binding.dart';
import 'package:clothes_app/modules/authentication/signup/signup_screen.dart';
import 'package:clothes_app/modules/cart/cart_screen.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_binding.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_screen.dart';
import 'package:clothes_app/modules/fragments/order/order_confirmation/order_confirmation_screen.dart';
import 'package:clothes_app/modules/fragments/order/order_detail/order_detail_screen.dart';
import 'package:clothes_app/modules/fragments/order/order_history/order_history_screen.dart';
import 'package:clothes_app/modules/fragments/order/order_now/order_now_screen.dart';
import 'package:clothes_app/modules/fragments/order/order_screen.dart';
import 'package:clothes_app/modules/item/item_details_screen.dart';
import 'package:clothes_app/modules/item/search_item/search_item_screen.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static String initial = Routes.login;

  static final routes = [
    //admin
    GetPage(
      name: Routes.adminLogin,
      page: () => const AdminLoginScreen(),
      binding: AdminLoginBindings(),
    ),
    GetPage(
      name: Routes.uploadItems,
      page: () => const AdminUploadItemsScreen(),
      binding: AdminUploadItemsBinding(),
    ),
    GetPage(
      name: Routes.orderAdmin,
      page: () => const OrderAdminScreen(),
      binding: OrderAdminBinding(),
    ),

    //user
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => const SignUpScreen(),
      binding: SignUpBindings(),
    ),
    GetPage(
      name: Routes.dashBoardFragment,
      page: () => const DashboardFragmentsScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    //oder
    GetPage(
      name: Routes.order,
      page: () => const OrderScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderNow,
      page: () => const OrderNowScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderConfirmation,
      page: () => const OrderConfirmationScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderDetail,
      page: () => const OrderDetailScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.orderHistory,
      page: () => const OrderHistoryScreen(),
      binding: DashboardFragmentsBinding(),
    ),

    //item
    GetPage(
      name: Routes.itemDetails,
      page: () => const ItemDetailScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.cart,
      page: () => const CartScreen(),
      binding: DashboardFragmentsBinding(),
    ),
    GetPage(
      name: Routes.searchSreen,
      page: () => const SearchScreen(),
      binding: DashboardFragmentsBinding(),
    )
  ];
}
