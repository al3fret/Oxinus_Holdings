import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const String _kFontFamily = 'IbarraNova';

  static TextStyle ibarraNova16SemiBoldBlack000000() {
    return const TextStyle(
        fontSize: 16,
        color: AppColors.colorBlack,
        fontFamily: _kFontFamily,
        fontWeight: FontWeight.w700);
  }

  static TextStyle ibarraNova18BoldWhiteFFFFFF() {
    return const TextStyle(
        fontSize: 18,
        color: AppColors.colorWhite,
        fontFamily: _kFontFamily,
        fontWeight: FontWeight.w700);
  }

  static TextStyle ibarraNova24BoldWhiteFFFFFF() {
    return const TextStyle(
        fontSize: 24,
        color: AppColors.colorWhite,
        fontFamily: _kFontFamily,
        fontWeight: FontWeight.w700);
  }



  static TextStyle ibarraNova18SemiBoldTextGray828282() {
    return const TextStyle(
        fontSize: 18,
        fontFamily: _kFontFamily,
        color: AppColors.colorTextGray,
        fontWeight: FontWeight.w600);
  }



}
