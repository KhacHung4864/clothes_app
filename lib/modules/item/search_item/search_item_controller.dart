import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/network/api/clothes_api/clothes_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchItemController extends GetxController {
  final ClothesApi _clothesApi = ClothesApi();
  SearchItemController();

  final String searchText = Get.arguments;
  TextEditingController searchController = TextEditingController();
  RxList<ClothItem> searchList = <ClothItem>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    searchController.text = searchText;
    getSearchItems();
    super.onInit();
  }

  @override
  void onClose() {}

  Future<void> getSearchItems() async {
    isLoading.value = true;
    searchList.value = [];
    String? token = AppStorage().getString(SKeys.tokenUser);
    if (token != null && token.isNotEmpty) {
      try {
        final response = await _clothesApi.callsearchItem(data: {'typedKeyWords': searchController.text.trim(), 'token': token});
        ClothesModel resData = ClothesModel.fromJson(jsonDecode(response.data));
        if (response.statusCode == 200) {
          if (resData.status == 'success') {
            resData.data?.forEach((record) {
              searchList.add(record);
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
}
