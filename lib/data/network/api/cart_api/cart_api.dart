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

  Future<Response> callUpdateCartItem({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.updateCartItem,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callDeleteCartItem({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.deleteCartItem,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callValidateFavorite({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.validateFavorite,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callAddFavorite({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.addFavorite,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callDeleteFavorite({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.deleteFavorite,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callFavoriteList({Map<String, dynamic>? data, bool isShowLoading = true}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.readFavorite,
        data: data,
        isShowLoading: isShowLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callAddNewOrder({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.neworder,
        data: data,
        isShowLoading: false,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callOrderList({Map<String, dynamic>? data, bool isShowLoading = true}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.readOrder,
        data: data,
        isShowLoading: isShowLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callOrderHistoryList({Map<String, dynamic>? data, bool isShowLoading = true}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.readHistoryOrder,
        data: data,
        isShowLoading: isShowLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateStatusItem({Map<String, dynamic>? data, bool isShowLoading = true}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.updateStatusOrder,
        data: data,
        isShowLoading: isShowLoading,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
