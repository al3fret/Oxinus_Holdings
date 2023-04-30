import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:base_flutter/widgets/gradient_button.dart';
import 'package:flutter/material.dart';

import '../utils/app_suitable_widget_size.dart';

class ErrorPage extends StatefulWidget {
  final VoidCallback onPressed;
  final String errorMessage;

  const ErrorPage(
      {Key? key, required this.onPressed, required this.errorMessage})
      : super(key: key);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: AppSuitableWidgetSize.getSuitableWidth(8)),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/error.jpg',
                  fit: BoxFit.contain,
                ),
                Text(
                  widget.errorMessage,
                  style: AppTextStyles.ibarraNova16SemiBoldBlack000000(),
                ),
                SizedBox(
                  height: AppSuitableWidgetSize.getSuitableHeight(15),
                ),
                GradientButton(
                  width: 0.75,
                  gradient: AppColors.linearGradient,
                  onPressed: widget.onPressed,
                  shadowColor: AppColors.colorOrange,
                  child: Text(
                    "Try Again",
                    style: AppTextStyles.ibarraNova18BoldWhiteFFFFFF(),
                  ),
                ),
                SizedBox(
                  height: AppSuitableWidgetSize.getSuitableHeight(35),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
