// ignore_for_file: unnecessary_string_escapes

import 'dart:math';

/// use this mixin for all form field
mixin ValidatorUlti {
  static bool isEmail(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return false;
    } else {
      return true;
    }
  }

  static bool isPhoneNumber(String phoneNo) {
    final regExp = RegExp(r'(^(?:[+0]9)?0[0-9]{9}$)');
    return regExp.hasMatch(phoneNo);
  }

  static String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = [" B", " KB", " MB", " GB", " TB"];
    if (bytes == 0) return '0${suffixes[0]}';
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
