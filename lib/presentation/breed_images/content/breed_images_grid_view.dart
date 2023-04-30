import 'package:base_flutter/domain/entities/breed_image.dart';
import 'package:base_flutter/presentation/breed_images/content/breed_images_list_Item.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_suitable_widget_size.dart';

Widget breedImagesGridView(List<BreedImage> items,
    Function(BreedImage) onTapFav, VoidCallback onRefresh) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: AppSuitableWidgetSize.getSuitableWidth(4),
        vertical: AppSuitableWidgetSize.getSuitableHeight(0)),
    child: RefreshIndicator(
      color: AppColors.colorOrange,
      onRefresh: () async {
        onRefresh();
      },
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            vertical: AppSuitableWidgetSize.getSuitableHeight(6)),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: breedImageListItem(items[index]),
            onTap: () {
              onTapFav(items[index],);

            },
          );
        },
      ),
    ),
  );
}
