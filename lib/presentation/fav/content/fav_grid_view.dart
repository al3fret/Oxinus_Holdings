import 'package:base_flutter/domain/entities/fav_list_item.dart';
import 'package:base_flutter/presentation/fav/content/fav_list_item.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_suitable_widget_size.dart';

Widget favGridView(List<FavListItem> items, Function(FavListItem) onTapFav) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: AppSuitableWidgetSize.getSuitableWidth(6),
        vertical: AppSuitableWidgetSize.getSuitableHeight(0)),
    child: GridView.builder(
      padding: EdgeInsets.symmetric(
          vertical: AppSuitableWidgetSize.getSuitableHeight(6)),
      itemCount: items.length,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 15.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          child: favListItem(items[index]),
          onTap: () {
            onTapFav(
              items[index],
            );
          },
        );
      },
    ),
  );
}
