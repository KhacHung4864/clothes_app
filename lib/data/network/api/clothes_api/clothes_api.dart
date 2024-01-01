import 'package:clothes_app/constants/app_url.dart';
import 'package:clothes_app/data/network/service/api_service.dart';
import 'package:dio/dio.dart';

class ClothesApi {
  final ApiService _apiService = ApiService();

  Future<Response> callTrendingClothItems({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.trendingClothes,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callAllClothItems({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.newClothes,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
