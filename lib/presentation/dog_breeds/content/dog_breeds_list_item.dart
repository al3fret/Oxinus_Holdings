import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/extension/string_extensions.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

Widget dogBreedsListItem(DogBreed dogBreed) {
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
      child: Center(
          child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (Rect bounds) {
          return AppColors.linearGradient.createShader(bounds);
        },
        child: Text(dogBreed.name.capitalizeFirst(),
            style: AppTextStyles.ibarraNova18SemiBoldTextGray828282()),
      )),
    ),
  );
}
