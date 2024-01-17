import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/order_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/cart/cart_controller.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  final CartApi cartApi = CartApi();
  final CartController cartController = Get.find();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  RxList<OrderData> orderList = <OrderData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    getCurrentUserorderList();
    super.onInit();
  }

  Future<void> getCurrentUserorderList({bool isShowLoading = true}) async {
    isLoading.value = true;
    orderList.value = [];
    int currentUserId = int.parse(dashboardFragmentsController.currentUser.value!.userId!);
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await cartApi.callOrderList(
        data: {'user_id': currentUserId, 'token': token},
        isShowLoading: isShowLoading,
      );
      OrderModel resData = OrderModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          resData.data?.forEach((record) {
            orderList.add(record);
          });
        } else {
          showError(resData.message);
        }
      } else {
        showError(resData.message);
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    } finally {
      isLoading.value = false;
    }
  }
}
