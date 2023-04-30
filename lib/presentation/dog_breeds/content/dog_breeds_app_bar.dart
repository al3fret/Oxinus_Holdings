
import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/app_colors.dart';

AppBar dogBreedsAppBar(VoidCallback onPressed) {
  return AppBar(


    backgroundColor: AppColors.colorOrange,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Text(
      "Dog Breeds",
      style: AppTextStyles.ibarraNova24BoldWhiteFFFFFF(),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.favorite),
        onPressed: () {
          onPressed();
        },
      ),
    ],
  );
}
