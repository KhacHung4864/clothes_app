import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/order_model.dart';
import 'package:clothes_app/data/network/api/admin_api/admin_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class OrderAdminController extends GetxController {
  final AdminApi _adminApi = AdminApi();
  RxList<OrderData> orderList = <OrderData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    getAdminOrderList();
    super.onInit();
  }

  Future<void> getAdminOrderList({bool isShowLoading = true}) async {
    isLoading.value = true;
    orderList.value = [];
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _adminApi.callAdminOrderList(
        data: {'token': token},
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
