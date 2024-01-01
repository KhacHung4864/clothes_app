import 'dart:convert';

import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:clothes_app/utils/share_components/dialog/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemDetailController extends GetxController {
  final CartApi _cartApi = CartApi();
  ItemDetailController();
  TextEditingController searchController = TextEditingController();
  final ClothItem clothItem = Get.arguments;
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  RxInt quantityItem = 1.obs;
  RxInt sizeItem = 0.obs;
  RxInt colorItem = 0.obs;
  RxBool isFavorite = false.obs;

  void setQuantity(int quantityOfItem) {
    quantityItem.value = quantityOfItem;
  }

  void addItemToCart(int userId, int itemId, int quantity, String color, String size) async {
    CartData cartInfo = CartData(
      userId: userId,
      itemId: itemId,
      quantity: quantity,
      color: color,
      size: size,
    );
    try {
      final response = await _cartApi.callAddItem(data: cartInfo.toJson());
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          ToastUtil.showSuccess(resData.message ?? '');
        } else {
          showError(resData.message);
        }
      } else {
        showError(resData.message);
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }
}
