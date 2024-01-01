import 'package:clothes_app/configs/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  static void show(String error) async {
    Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: error,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Palette.black,
      textColor: Palette.white,
      fontSize: 16.sp,
    );
  }

  static void showSuccess(String message) async {
    Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Palette.success.withOpacity(0.5),
      textColor: Palette.white,
      fontSize: 16.sp,
    );
  }
}
