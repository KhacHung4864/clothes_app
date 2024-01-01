import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/network/api/clothes_api/clothes_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  HomeController();
  final ClothesApi _clothesApi = ClothesApi();
  TextEditingController searchController = TextEditingController();

  Future<List<ClothItem>> getTrendingClothItems() async {
    List<ClothItem> listTrendingClothItems = [];
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
    List<ClothItem> listAllClothItems = [];
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
