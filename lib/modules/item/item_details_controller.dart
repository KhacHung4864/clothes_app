import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/modules/fragments/favorites/favorites_controller.dart';
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
  final FavoritesController favoritesController = Get.find();

  RxInt quantityItem = 1.obs;
  RxInt sizeItem = 0.obs;
  RxInt colorItem = 0.obs;
  RxBool isFavorite = false.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    validateFavoriteList();
    super.onInit();
  }

  void setQuantity(int quantityOfItem) {
    quantityItem.value = quantityOfItem;
  }

  void validateFavoriteList() async {
    isLoading.value = true;
    CartData cartInfo = CartData(
      userId: int.parse(dashboardFragmentsController.currentUser.value!.userId!),
      itemId: clothItem.itemId,
    );
    try {
      final response = await _cartApi.callValidateFavorite(data: cartInfo.toJson());
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          isFavorite.value = false;
        } else {
          isFavorite.value = true;
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

  void addItemToFavoriteList() async {
    CartData cartInfo = CartData(
      userId: int.parse(dashboardFragmentsController.currentUser.value!.userId!),
      itemId: clothItem.itemId,
    );
    try {
      final response = await _cartApi.callAddFavorite(data: cartInfo.toJson());
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          validateFavoriteList();
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

  void deleteItemFromFavoriteList() async {
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callDeleteFavorite(
        data: {'user_id': int.parse(dashboardFragmentsController.currentUser.value!.userId!), 'item_id': clothItem.itemId, 'token': token},
      );
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          validateFavoriteList();
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

  void addItemToCart() async {
    CartData cartInfo = CartData(
      userId: int.parse(dashboardFragmentsController.currentUser.value!.userId!),
      itemId: clothItem.itemId,
      quantity: quantityItem.value,
      color: clothItem.colors![colorItem.value].replaceAll('[', '').replaceAll(']', ''),
      size: clothItem.sizes![sizeItem.value].replaceAll('[', '').replaceAll(']', ''),
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
