import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/favorite_model.dart';
import 'package:clothes_app/data/network/api/cart_api/cart_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/modules/fragments/dashboard_fragments_controller.dart';
import 'package:clothes_app/modules/fragments/home/home_controller.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class FavoritesController extends GetxController {
  final CartApi _cartApi = CartApi();
  FavoritesController();
  final DashboardFragmentsController dashboardFragmentsController = Get.find();
  final HomeController homeController = Get.find();
  RxBool isLoading = false.obs;
  RxList<FavoriteData> favoriteList = <FavoriteData>[].obs;

  @override
  void onInit() async {
    await initData();
    super.onInit();
  }

  Future<void> initData({bool isShowLoading = true}) async {
    await Future.wait([
      getCurrentUserFavoriteList(isShowLoading: isShowLoading),
    ]);
  }

  Future<void> getCurrentUserFavoriteList({bool isShowLoading = true}) async {
    isLoading.value = true;
    favoriteList.value = [];
    int currentUserId = int.parse(dashboardFragmentsController.currentUser.value!.userId!);
    String? token = AppStorage().getString(SKeys.tokenUser);
    try {
      final response = await _cartApi.callFavoriteList(
        data: {'user_id': currentUserId, 'token': token},
        isShowLoading: isShowLoading,
      );
      FavoriteModel resData = FavoriteModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          resData.data?.forEach((record) {
            favoriteList.add(record);
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
