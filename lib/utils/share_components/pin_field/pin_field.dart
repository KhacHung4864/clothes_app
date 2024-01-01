import 'package:clothes_app/utils/share_components/pin_field/obsscursing_widget.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../configs/Palette.dart';
import '../../../configs/app_fonts.dart';
import '../../../configs/theme.dart';

class MyPinField extends StatelessWidget {
  const MyPinField(
      {Key? key,
      this.controller,
      this.isError,
      this.onChange,
      this.onComplete,
      this.padding = EdgeInsets.zero,
      this.pinTheme,
      this.textStyle,
      this.showCursor = true,
      this.enabled = true,
      this.blinkWhenObscuring = true,
      this.obscureText = true,
      this.focusNode,
      this.readOnly = false,
      this.length = 4,
      this.size = 65,
      this.autoFocus = false})
      : super(key: key);

  final TextEditingController? controller;
  final bool? isError;
  final Function(String)? onChange;
  final Function(String)? onComplete;
  final EdgeInsets padding;
  final PinTheme? pinTheme;
  final TextStyle? textStyle;
  final bool showCursor;
  final bool enabled;
  final bool blinkWhenObscuring;
  final bool obscureText;
  final FocusNode? focusNode;
  final bool readOnly;
  final int length;
  final double size;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: PinCodeTextField(
        enablePinAutofill: false,
        autoDisposeControllers: false,
        readOnly: readOnly,
        focusNode: focusNode,
        enabled: enabled,
        showCursor: showCursor,
        obscuringWidget: const ObscursingWidget(),
        autoFocus: autoFocus,
        obscureText: obscureText,
        blinkWhenObscuring: blinkWhenObscuring,
        controller: controller,
        appContext: context,
        cursorWidth: 1,
        pastedTextStyle: textStyle ?? AppFont.t.s(20),
        textStyle: textStyle ?? AppFont.t.s(20),
        length: length,
        cursorColor: Palette.black,
        animationType: AnimationType.fade,
        pinTheme: pinTheme ?? AppTheme.pinTheme(size),
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        keyboardType: TextInputType.number,
        onCompleted: onComplete,
        onChanged: onChange ?? (_) {},
        validator: (v) {
          return '';
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
