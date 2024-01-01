import 'dart:convert';

import 'package:clothes_app/data/model/user_model.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/network/api/user_api.dart';
import '../../../data/network/service/api_exception.dart';

class SignUpController extends GetxController {
  final UserApi _userApi = UserApi();

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid || nameController.text.trim().isEmpty && emailController.text.trim().isEmpty && passwordController.text.trim().isEmpty) {
      return;
    }
    checkUser(data: {
      'user_email': emailController.text.trim(),
    });
  }

  void checkUser({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.callCheckUser(data: data);
      UserModel resData = UserModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          UserData user = UserData(
            userName: nameController.text.trim(),
            userEmail: emailController.text.trim(),
            userPassword: passwordController.text.trim(),
          );
          signUpUser(data: user.toJson());
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

  void signUpUser({Map<String, dynamic>? data}) async {
    try {
      final response = await _userApi.callsignUpUser(data: data);
      UserModel resData = UserModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        if (resData.status == 'success') {
          Get.back();
          showDialogSuccess(resData.message);
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

  // void updateUser(String id, {Map<String, dynamic>? data}) async {
  //   try {
  //     final response = await _userApi.putUser(id, data: data);
  //     if (response.statusCode == 200) {
  //       checkUser();
  //     }
  //   } on DioException catch (e) {
  //     final ApiException apiException = ApiException.fromDioError(e);
  //     throw apiException;
  //   }
  // }

  // void deleteUser(String id) async {
  //   try {
  //     final response = await _userApi.deleteUser(id);
  //     if (response.statusCode == 200) {
  //       checkUser();
  //     }
  //   } on DioException catch (e) {
  //     final ApiException apiException = ApiException.fromDioError(e);
  //     throw apiException;
  //   }
  // }
}
