import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartApi _cartApi = CartApi();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  RxList<CartData> cartList = <CartData>[].obs;
  RxList<int> selectedItemList = <int>[].obs;
  RxBool isSelectedAll = false.obs;
  RxDouble total = 0.0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await getCartList();
    super.onInit();
  }

  void addSelectedItem(int selectedItemId) {
    selectedItemList.add(selectedItemId);
    update();
  }

  void deleteSelectedItem(int selectedItemId) {
    selectedItemList.remove(selectedItemId);
    update();
  }

  void setIsSelectedAll() {
    isSelectedAll.value = !isSelectedAll.value;
    update();
  }

  void clearAllSelectedItem() {
    selectedItemList.clear();
    update();
  }

  void calculateTotalAmount() {
    total.value = 0;
    if (selectedItemList.isNotEmpty) {
      for (var itemInCart in cartList) {
        if (selectedItemList.contains(itemInCart.cartId)) {
          double eachItemTotalAmount = (itemInCart.price!) * (double.parse(itemInCart.quantity.toString()));
          total.value = total.value + eachItemTotalAmount;
        }
      }
    }
  }

  getCartList() async {
    isLoading.value = true;
    cartList.value = [];
    int currentUserId = int.parse(dashboardFragmentsController.currentUser.value!.userId!);
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callCartList(data: {'user_id': currentUserId, 'token': token});
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          resData.data?.forEach((record) {
            cartList.add(record);
            calculateTotalAmount();
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

  updateQuantityInUserCart(int? cartId, int? quantity) async {
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callUpdateCartItem(data: {'token': token, 'cart_id': cartId, 'quantity': quantity});
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          getCartList();
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

  deleteSelectedItemsFromUserCartList(int? cartId) async {
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callDeleteCartItem(data: {'token': token, 'cart_id': cartId});
      CartModel resData = CartModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          getCartList();
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
