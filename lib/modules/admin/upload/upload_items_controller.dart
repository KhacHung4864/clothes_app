import 'dart:convert';

import 'package:clothes_app/data/model/clothes_model.dart';
import 'package:clothes_app/data/model/imgur_api_model.dart';
import 'package:clothes_app/data/network/api/admin_api/admin_api.dart';
import 'package:clothes_app/data/network/service/api_exception.dart';
import 'package:clothes_app/utils/share_components/dialog/dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminUploadItemsController extends GetxController {
  final AdminApi _adminApi = AdminApi();
  final ImagePicker picker = ImagePicker();
  Rx<XFile?> pickedImageXfile = Rx<XFile?>(null);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ratingController = TextEditingController();
  final tagsController = TextEditingController();
  final priceController = TextEditingController();
  final sizesController = TextEditingController();
  final colorsController = TextEditingController();
  final descriptionController = TextEditingController();
  var imageLink = '';

  void submit() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid ||
        nameController.text.trim().isEmpty &&
            ratingController.text.trim().isEmpty &&
            tagsController.text.trim().isEmpty &&
            priceController.text.trim().isEmpty &&
            sizesController.text.trim().isEmpty &&
            colorsController.text.trim().isEmpty &&
            descriptionController.text.trim().isEmpty) {
      return;
    }
    await uploadImage();
    formKey.currentState!.save();
  }

  Future<void> uploadImage() async {
    try {
      final response = await _adminApi.callUpLoadItemImage(pickedImageXfile.value!.path);
      if (response.statusCode == 200) {
        ImgurApiModel responDataFromImgurApi = ImgurApiModel.fromJson(response.data);
        imageLink = responDataFromImgurApi.data!.link!;
        //String deleteHash = responDataFromImgurApi.data!.deletehash!;
        // showError(' Upload successful');
        await uploadItemInfo();
      } else {
        showError('Error when uploading photos. Error code:  ${response.statusCode}');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }

  Future<void> uploadItemInfo() async {
    List<String> tagsList = tagsController.text.split(',');
    List<String> sizesList = sizesController.text.split(',');
    List<String> colorsList = colorsController.text.split(',');
    ClothItem itemInfor = ClothItem(
      name: nameController.text.trim(),
      rating: double.parse(ratingController.text.trim()),
      tags: tagsList,
      price: double.parse(priceController.text.trim()),
      sizes: sizesList,
      colors: colorsList,
      description: descriptionController.text.trim(),
      image: imageLink,
    );
    try {
      final response = await _adminApi.callUploadItemInfo(data: itemInfor.toJson());
      ClothesModel resData = ClothesModel.fromJson(jsonDecode(response.data));
      if (response.statusCode == 200) {
        clearData();
        showError(resData.message);
      } else {
        showError(resData.message);
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioError(e);
      throw apiException;
    }
  }

  captureImageWithPhoneCamera() async {
    pickedImageXfile.value = await picker.pickImage(source: ImageSource.camera);
    Get.back();
  }

  pickImageFromPhoneGallery() async {
    pickedImageXfile.value = await picker.pickImage(source: ImageSource.gallery);
    Get.back();
  }

  void clearData() {
    pickedImageXfile.value = null;
    nameController.clear();
    ratingController.clear();
    tagsController.clear();
    priceController.clear();
    sizesController.clear();
    colorsController.clear();
    descriptionController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    ratingController.dispose();
    tagsController.dispose();
    priceController.dispose();
    sizesController.dispose();
    colorsController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
