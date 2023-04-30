import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../utils/app_suitable_widget_size.dart';

class EmptyPage extends StatefulWidget {
  const EmptyPage({Key? key}) : super(key: key);

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: AppSuitableWidgetSize.getSuitableWidth(80),
              height: AppSuitableWidgetSize.getSuitableHeight(80),
              child: Image.asset(
                'assets/images/empty.png',
              ),
            ),
            SizedBox(
              height: AppSuitableWidgetSize.getSuitableHeight(10),
            ),
            RichText(
              text: TextSpan(
                text: 'No data found',
                style: AppTextStyles.ibarraNova16SemiBoldBlack000000(),
              ),
            ),
            SizedBox(
              height: AppSuitableWidgetSize.getSuitableHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
