import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';
import 'app_suitable_widget_size.dart';

void showToastNoConnectionError() {
  Fluttertoast.showToast(
      msg:
      'Please check your internet connection',
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.colorGray464645,
      textColor: AppColors.colorWhite,
      fontSize: AppSuitableWidgetSize.getSuitableHeight(14));
  }