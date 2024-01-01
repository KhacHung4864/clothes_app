import 'package:clothes_app/constants/app_url.dart';
import 'package:clothes_app/data/network/service/api_service.dart';
import 'package:dio/dio.dart';

class CartApi {
  final ApiService _apiService = ApiService();

  Future<Response> callAddItem({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.additem,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callCartList({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.cartList,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
