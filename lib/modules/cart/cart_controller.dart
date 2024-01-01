import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/cart_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:clothes_app/utils/share_components/dialog/toast.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartApi _cartApi = CartApi();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();

  RxList<CartData> cartLists = <CartData>[].obs;
  RxList<int> selectedItemLists = <int>[].obs;
  RxBool isSelectedAll = false.obs;
  RxDouble total = 0.0.obs;

  @override
  void onInit() async {
    await getCartList();
    super.onInit();
  }

  void addSelectedItem(int selectedItemId) {
    selectedItemLists.add(selectedItemId);
    update();
  }

  void deleteSelectedItem(int selectedItemId) {
    selectedItemLists.remove(selectedItemId);
    update();
  }

  void setIsSelectedAll() {
    isSelectedAll.value = !isSelectedAll.value;
    update();
  }

  void clearAllSelectedItem(int selectedItemId) {
    selectedItemLists.clear();
    update();
  }

  getCartList() async {
    int currentUser = int.parse(dashboardFragmentsController.currentUser.value!.userId!);
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callCartList(data: {'user_id': currentUser, 'token': token});
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
