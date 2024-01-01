import 'dart:convert';

import 'package:clothes_app/data/local/app_storage.dart';
import 'package:clothes_app/data/model/user_model.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';

class LoginController extends GetxController {
  final UserApi _userApi = UserApi();

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
    loginUser(data: {
      'user_email': emailController.text.trim(),
      'user_password': passwordController.text.trim(),
    });
    formKey.currentState!.save();
  }

  void loginUser({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.callLoginUser(data: data);
      UserModel resData = UserModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          AppStorage().setString(SKeys.tokenUser, resData.token ?? '');
          Get.toNamed(Routes.dashBoardFragment);
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
