
import 'package:base_flutter/extension/string_extensions.dart';
import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

AppBar breedImagesAppBar(String title) {
  return AppBar(
    backgroundColor: AppColors.colorOrange,
    centerTitle: true,
    title: Text(
      title.capitalizeFirst(),
      style: AppTextStyles.ibarraNova24BoldWhiteFFFFFF(),
    ),
  );
}
