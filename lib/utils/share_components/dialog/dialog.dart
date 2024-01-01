import 'package:clothes_app/configs/app_fonts.dart';
import 'package:clothes_app/configs/palette.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../loading/loading.dart';
import 'dialog_succes.dart';

enum ToastType { success, error, warning }

Future showLoading() {
  return Get.dialog(
    barrierDismissible: false,
    useSafeArea: false,
    const Loading(),
  );
}

Future showDialogConfirm(String? title, String? content) {
  return Get.dialog(AlertDialog(
    backgroundColor: Palette.grey,
    title: Text(title ?? '', style: AppFont.t.s(18).bold),
    content: Text(content ?? ''),
    actions: [
      TextButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          'No',
          style: AppFont.t.black,
        ),
      ),
      TextButton(
        onPressed: () {
          Get.back(result: 'loggedOut');
        },
        child: Text(
          'Yes',
          style: AppFont.t.black,
        ),
      ),
    ],
  ));
}

Future showDialogSuccess(String? title, [String? desc, int timeForDismiss = 1000]) async {
  await dialogAnimationWrapper(
    timeForDismiss: timeForDismiss,
    child: DialogSuccess(
      text: title ?? "",
      desc: desc,
    ),
  );
}

Future dialogAnimationWrapper({
  child,
  duration = 400,
  backgroundColor = Colors.white,
  timeForDismiss,
}) {
  if (timeForDismiss != null) {
    Future.delayed(Duration(milliseconds: timeForDismiss), () {
      Get.back();
    });
  }

  return Get.generalDialog(
    transitionDuration: Duration(milliseconds: duration),
    pageBuilder: (_, __, ___) => child,
    transitionBuilder: (_, anim, __, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 0), end: const Offset(0, 0)).animate(anim),
        child: child,
      );
    },
  );
}

Future<bool?> showError(String? message) {
  return Fluttertoast.showToast(
    msg: message ?? 'Lỗi không xác định',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Palette.red,
    textColor: Palette.background,
    fontSize: 14.0,
  );
}

Future<bool?> dismissLoadingShowError(String? message) {
  Get.back();
  return Fluttertoast.showToast(
    msg: message ?? 'Lỗi không xác định',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Palette.red,
    textColor: Palette.background,
    fontSize: 14.0,
  );
}

void dismissLoading() {
  return Get.back();
}
