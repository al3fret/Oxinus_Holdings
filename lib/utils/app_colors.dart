import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppColors {
  //Custom Color
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color colorBlack = Color(0xFF000000);
  static const Color colorOrange = Color(0xFFF08619);
  static const Color colorRed = Color(0xFF9D1A16);
  static const Color colorGray = Color(0xFFF0F0F0);
  static const Color colorGray464645 = Color(0xFF464645);
  static const Color colorTextGray = Color(0xFF828282);

  static MaterialStateProperty<Color> colorOrangeMaterialStateProperty =
      MaterialStateProperty.resolveWith((states) {
    return colorOrange;
  });

  static const Gradient linearGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      tileMode: TileMode.mirror,
      colors: [colorOrange, colorOrange, colorRed]);
}
