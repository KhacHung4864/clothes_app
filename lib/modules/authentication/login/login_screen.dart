import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:clothes_app/constants/validator.dart';
import 'package:clothes_app/gen/assets.gen.dart';
import 'package:clothes_app/modules/authentication/login/login_controller.dart';
import 'package:clothes_app/modules/authentication/widget/text_form_field_widget.dart';
import 'package:clothes_app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.black,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //loign screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285.h,
                    child: Assets.images.login.image(),
                  ),

                  //login screen sign-in form
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
                                  //email
                                  TextFormFieldWidget(
                                    title: 'Email',
                                    controller: controller.emailController,
                                    icon: Icons.email,
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty || ValidatorUlti.isEmail(value.trim())) {
                                        return 'Please enter a valid email address.';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 16.h),

                                  //password
                                  TextFormFieldWidget(
                                    title: 'Password',
                                    controller: controller.passwordController,
                                    icon: Icons.vpn_key_sharp,
                                    validator: (value) {
                                      if (value == null || value.trim().length < 4) {
                                        return 'Password must be at least 4 characters long';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 18.h),

                                  //button
                                  Material(
                                    color: Palette.black,
                                    borderRadius: BorderRadius.circular(30.sp),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(30.sp),
                                      onTap: controller.submit,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 10.h),
                                        child: Text(
                                          'Login',
                                          style: AppFont.t.s(16).w400.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //dont have an account btn
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an Account?"),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.signUp);
                                    },
                                    child: Text(
                                      'Register Here',
                                      style: AppFont.t.s(16).purpleAccent,
                                    ))
                              ],
                            ),

                            Text(
                              'Or',
                              style: AppFont.t.s(16).grey66,
                            ),

                            //are you admin - btn
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Are you an Admin?"),
                                TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.adminLogin);
                                    },
                                    child: Text(
                                      'Click Here',
                                      style: AppFont.t.s(16).purpleAccent,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
