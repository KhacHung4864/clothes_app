import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/network/api/clothes_api/clothes_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController();
  final ClothesApi _clothesApi = ClothesApi();
  TextEditingController searchController = TextEditingController();
  RxList<ClothItem> listAllClothItems = <ClothItem>[].obs;

  RxList<ClothItem> listTrendingClothItems = <ClothItem>[].obs;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  Future<void> initData() async {
    await Future.wait([
      getTrendingClothItems(),
      getAllClothItems(),
    ]);
  }

  Future<List<ClothItem>> getTrendingClothItems() async {
    listTrendingClothItems.value = [];
    String? token = AppStorage().getString(SKeys.tokenUser);
    if (token != null && token.isNotEmpty) {
      try {
        final response = await _clothesApi.callTrendingClothItems(data: {
          'token': token,
        });
        ClothesModel resData = ClothesModel.fromJson(jsonDecode(response.data));
        if (response.statusCode == 200) {
          if (resData.status == 'success') {
            resData.data?.forEach((record) {
              listTrendingClothItems.add(record);
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
      }
    }
    return listTrendingClothItems;
  }

  Future<List<ClothItem>> getAllClothItems() async {
    listAllClothItems.value = [];
    String? token = AppStorage().getString(SKeys.tokenUser);
    if (token != null && token.isNotEmpty) {
      try {
        final response = await _clothesApi.callAllClothItems(data: {
          'token': token,
        });
        ClothesModel resData = ClothesModel.fromJson(jsonDecode(response.data));
        if (response.statusCode == 200) {
          if (resData.status == 'success') {
            resData.data?.forEach((record) {
              listAllClothItems.add(record);
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
      }
    }
    return listAllClothItems;
  }
}
