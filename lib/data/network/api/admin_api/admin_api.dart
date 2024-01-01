import 'package:clothes_app/constants/app_url.dart';
import 'package:clothes_app/data/network/service/api_service.dart';
import 'package:dio/dio.dart';

class AdminApi {
  final ApiService _apiService = ApiService();

  Future<Response> callLoginAdmin({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.logInAdmin,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUpLoadItemImage(String filePath) async {
    try {
      //Unique name from the present time
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      FormData formData = FormData.fromMap({
        'title': imageName,
        'image': await MultipartFile.fromFile(
          filePath,
          filename: imageName,
        ),
      });
      final Response response = await _apiService.post(
        AppUrl.upLoadImage,
        data: formData,
        options: Options(
          headers: {'Authorization': 'Client-ID f8863e0aab245e2'},
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> callUploadItemInfo({Map<String, dynamic>? data}) async {
    try {
      final Response response = await _apiService.post(
        AppUrl.uploadNewItem,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
