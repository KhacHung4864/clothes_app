import 'package:clothes_app/constants/app_url.dart';
import 'package:dio/dio.dart';

import '../service/api_service.dart';

class UserApi {
  final ApiService _apiService = ApiService();

  Future<Response> callCheckUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(AppUrl.validateEmail, data: data, options: Options());
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callsignUpUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.signUpUser,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callLoginUser({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.logInUser,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUserData({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.getUserFromToken,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Future<Response> putUser(String id, {Map<String, dynamic>? data}) async {
  //   try {
  //     final Response response = await _apiService.put(
  //       '${AppUrl.users}/$id',
  //       data: data,
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<Response> deleteUser(String id) async {
  //   try {
  //     final Response response = await _apiService.delete(
  //       '${AppUrl.users}/$id',
  //     );
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
