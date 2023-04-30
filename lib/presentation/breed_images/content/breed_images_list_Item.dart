import 'package:base_flutter/domain/entities/breed_image.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/utils/app_suitable_widget_size.dart';
import 'package:base_flutter/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';

Widget breedImageListItem(
    BreedImage breedImage) {
  return GridTile(
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.colorGray,
        boxShadow: const [
          BoxShadow(
            color: AppColors.colorGray,
            blurRadius: 1,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: DogImageWidget(imageUrl: breedImage.imageUrl)),
          Positioned(
            top: 1,
            right: 1,
            child: Icon(
              breedImage.isFav ? Icons.favorite : Icons.favorite_border,
              color: AppColors.colorOrange,
              size: (AppSuitableWidgetSize.getSuitableHeight(14) +
                  AppSuitableWidgetSize.getSuitableWidth(14)) /
                  2,
            ),

          ),
        ],
      ),
    ),
  );
}
