import 'dart:io';

import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/modules/admin/upload/upload_items_controller.dart';
import 'package:clothes_app/modules/authentication/widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminUploadItemsScreen extends GetView<AdminUploadItemsController> {
  const AdminUploadItemsScreen({super.key});

  get context => BuildContext;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pickedImageXfile.value == null ? defaultScreen() : uploadItemFromScreen());
  }

  // add new item methods
  Scaffold defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Admin'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Palette.purpleAccent,
              Palette.black38,
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Palette.black54,
              Palette.deppPurple,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_photo_alternate,
                  color: Palette.white54,
                  size: 200.sp,
                ),
                Material(
                  color: Palette.black38,
                  borderRadius: BorderRadius.circular(30.sp),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30.sp),
                    onTap: () {
                      showDialogBoxForImagePickingAndCapturing();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
                      child: Text(
                        'Add New Item',
                        style: AppFont.t.s(16).w400.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Upload item from screen methods
  Scaffold uploadItemFromScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Form',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Palette.deppPurple,
                Palette.black54,
              ],
            ),
          ),
        ),
        leading: IconButton(
          onPressed: controller.clearData,
          icon: const Icon(Icons.clear),
        ),
        actions: [
          TextButton(
              onPressed: controller.submit,
              child: Text(
                'Done',
                style: AppFont.t.success,
              ))
        ],
      ),
      backgroundColor: Palette.black,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Container(
              height: 240.h,
              width: Get.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(
                      File(controller.pickedImageXfile.value!.path),
                    ),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.all(
                  Radius.circular(60.sp),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8.sp,
                    color: Colors.black26,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.w, 30.h, 30.w, 8.h),
                child: Column(
                  children: [
                    //email-pasword-login-btn
                    Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          //item name
                          TextFormFieldWidget(
                            title: 'Item name...',
                            controller: controller.nameController,
                            icon: Icons.title,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item name.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item rate
                          TextFormFieldWidget(
                            title: 'Item rating...',
                            controller: controller.ratingController,
                            icon: Icons.rate_review,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please give item rating.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item tags
                          TextFormFieldWidget(
                            title: 'Item tags...',
                            controller: controller.tagsController,
                            icon: Icons.tag,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item tags.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item price
                          TextFormFieldWidget(
                            title: 'Item price...',
                            controller: controller.priceController,
                            icon: Icons.price_change_outlined,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item price.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item size
                          TextFormFieldWidget(
                            title: 'Item size...',
                            controller: controller.sizesController,
                            icon: Icons.picture_in_picture,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item size.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item color
                          TextFormFieldWidget(
                            title: 'Item color...',
                            controller: controller.colorsController,
                            icon: Icons.color_lens,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item colors.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 16.h),

                          //item description
                          TextFormFieldWidget(
                            title: 'Item description...',
                            controller: controller.descriptionController,
                            icon: Icons.description,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please write item description.';
                              }
                              return null;
                            },
                          ),

                          SizedBox(height: 18.h),

                          //button upLoad Item
                          Material(
                            color: Palette.black,
                            borderRadius: BorderRadius.circular(30.sp),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.sp),
                              onTap: controller.submit,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                                child: Text(
                                  'Upload Now',
                                  style: AppFont.t.s(16).w400.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //show box select pick image method
  Future showDialogBoxForImagePickingAndCapturing() {
    return Get.dialog(SimpleDialog(
      backgroundColor: Palette.black,
      title: Text(
        'Item Image',
        style: AppFont.t.bold.deepPurple,
      ),
      children: [
        SimpleDialogOption(
          onPressed: controller.captureImageWithPhoneCamera,
          child: Text(
            'Capture with Phone Camera',
            style: AppFont.t.grey,
          ),
        ),
        SimpleDialogOption(
          onPressed: controller.pickImageFromPhoneGallery,
          child: Text(
            'Pick Image From Phone Gallery',
            style: AppFont.t.grey,
          ),
        ),
        SimpleDialogOption(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'Cancel',
            style: AppFont.t.red,
          ),
        )
      ],
    ));
  }
}
