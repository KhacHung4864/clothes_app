import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/user_model.dart';
import 'package:clothes_app/data/network/api/admin_api/admin_api.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/service/api_exception.dart';

class AdminLoginController extends GetxController {
  final AdminApi _adminApi = AdminApi();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty) {
      return;
    }
    loginAdmin(data: {
      'admin_email': emailController.text.trim(),
      'admin_password': passwordController.text.trim(),
    });
    formKey.currentState!.save();
  }

  void loginAdmin({Map<String, dynamic>? data}) async {
    try {
      final response = await _adminApi.callLoginAdmin(data: data);
      UserModel resData = UserModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          AppStorage().setString(SKeys.tokenAdmin, resData.token ?? '');
          Get.toNamed(Routes.uploadItems);
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
