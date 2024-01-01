import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/fragments/profile/proflile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.all(32.sp), children: [
      Center(
        child: Assets.images.man.image(width: 240.w),
      ),
      SizedBox(height: 20.h),
      userInforItem(Icons.person, controller.dashboardFragmentsController.currentUser.value?.userName),
      SizedBox(height: 20.h),
      userInforItem(Icons.email, controller.dashboardFragmentsController.currentUser.value?.userEmail),
      SizedBox(height: 20.h),
      Center(
        child: Material(
          color: Palette.redAccent,
          borderRadius: BorderRadius.circular(8.sp),
          child: InkWell(
            borderRadius: BorderRadius.circular(32.sp),
            onTap: controller.signOutUser,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
              child: Text(
                'Sign Out',
                style: AppFont.t.s(16).w400.white,
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Container userInforItem(IconData iconData, String? userData) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Palette.grey),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(iconData, size: 30, color: Palette.black),
          const SizedBox(width: 16),
          Text(
            userData ?? '',
            style: AppFont.t.s(15),
          ),
        ],
      ),
    );
  }
}
