
import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class AppTheme {
  static EdgeInsets mainHorizEdge = EdgeInsets.symmetric(horizontal: 20.w);
  static ThemeData themData = ThemeData(
    scaffoldBackgroundColor: Palette.background,
  );
  static InputDecorationTheme textFormField() => InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        hintStyle: AppFont.t.s().w400.hint,
        focusColor: Palette.blue,
        errorMaxLines: 2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: Palette.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Palette.gray97,
          ),
        ),
      );

  static PinTheme pinTheme([double size = 65]) => PinTheme(
        fieldWidth: size.w,
        fieldHeight: size.h,
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(4.r),
        borderWidth: 1,
        activeFillColor: Palette.grayF6,
        disabledColor: Palette.grayBE,
        inactiveFillColor: Palette.grayF6,
        selectedColor: Palette.grayBE,
        inactiveColor: Palette.grayF6,
        selectedFillColor: Palette.grayF6,
        activeColor: Palette.grayF6,
      );
}
