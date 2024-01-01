import 'package:clothes_app/configs/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/box.dart';

class DialogSuccess extends StatelessWidget {
  const DialogSuccess({super.key, required this.text, this.desc});
  final String text;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(27),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Assets.images.icSuccess.svg(),
            Box.h(20),
            Text(
              text,
              style: AppFont.t.s(18).w600.blue007EB8,
              textAlign: TextAlign.center,
            ),
            if (desc != null)
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  desc!,
                  style: AppFont.t.s(15),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
