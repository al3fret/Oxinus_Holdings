import 'package:base_flutter/utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_suitable_widget_size.dart';

class DogImageWidget extends StatelessWidget {
  final String imageUrl;

  const DogImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: CachedNetworkImage(

        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            Center(
              child: CircularProgressIndicator(
                color: AppColors.colorOrange,
                strokeWidth: AppSuitableWidgetSize.getSuitableWidth(1),
              ),
            ),
        errorWidget:(context, url, error) =>  Icon(
          Icons.error,
          size: (AppSuitableWidgetSize.getSuitableHeight(15) +
              AppSuitableWidgetSize.getSuitableWidth(15)) /
              2,
          color: AppColors.colorOrange,
        ),
      ),
    );
  }
}
