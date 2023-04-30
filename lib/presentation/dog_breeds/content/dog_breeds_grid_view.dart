import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_suitable_widget_size.dart';
import 'dog_breeds_list_item.dart';

Widget dogBreedsGridView(
    List<DogBreed> items, Function(DogBreed) onTap, VoidCallback onRefresh) {
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
        addAutomaticKeepAlives: true,
        padding: EdgeInsets.symmetric(
            vertical: AppSuitableWidgetSize.getSuitableHeight(6)),
        itemCount: items.length,
        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                onTap(items[index]);

              },
              child: dogBreedsListItem(items[index]));
        },
      ),
    ),
  );
}
