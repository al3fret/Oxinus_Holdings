import 'package:flutter/material.dart';

import '../utils/app_suitable_widget_size.dart';


class GradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final Color shadowColor;

  final VoidCallback onPressed;

  const GradientButton({
    Key? key,
    required this.child,
    required this.width,
    required this.gradient,
    required this.shadowColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * width,
      height: AppSuitableWidgetSize.getSuitableHeight(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
              AppSuitableWidgetSize.getSuitableHeight(25))),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0.5, 0.5),
              blurRadius: 4,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
