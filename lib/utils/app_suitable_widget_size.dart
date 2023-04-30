import 'package:flutter/material.dart';

class AppSuitableWidgetSize {
  // It's the AdobeXD Device Height
 static double targetHeightSize = 926;

  // It's the AdobeXD Device Width
 static double targetWidthSize = 428;

 static double getSuitableHeight(double targetWidgetHeight) {
    final windowSize = WidgetsBinding.instance.window.physicalSize;

    if (windowSize.aspectRatio > 0.463) {
      targetHeightSize = 736;
      return (windowSize.height * targetWidgetHeight * 0.85) / targetHeightSize;
    } else {
      targetHeightSize = 896;

      return (windowSize.height * targetWidgetHeight) /
          targetHeightSize; // It's the AdobeXD Device Width
    }
  }

  static double getSuitableWidth(double targetWidgetWidth) {
    final windowSize = WidgetsBinding.instance.window.physicalSize;

    if (windowSize.aspectRatio > 0.463) {
      targetWidthSize = 414;
    } else {
      targetWidthSize = 428;
    }

    return (windowSize.width * targetWidgetWidth) / targetWidthSize;
  }
}
