import 'package:base_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../utils/app_suitable_widget_size.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsetsDirectional.all(
              AppSuitableWidgetSize.getSuitableHeight(8)),
          child: SizedBox(
            height:
                AppSuitableWidgetSize.getSuitableHeight(12),
            width: AppSuitableWidgetSize.getSuitableWidth(12),
            child: CircularProgressIndicator(
              strokeWidth:
              AppSuitableWidgetSize.getSuitableWidth(1),
              valueColor: const AlwaysStoppedAnimation(AppColors.colorOrange),
            ),
          ),
        ),
      ],
    ));
  }
}
