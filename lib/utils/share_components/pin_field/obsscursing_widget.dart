import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/Palette.dart';

class ObscursingWidget extends StatelessWidget {
  const ObscursingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 11.h,
        width: 11.h,
        decoration: const BoxDecoration(color: Palette.grayC4),
      ),
    );
  }
}
