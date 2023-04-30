import 'package:base_flutter/presentation/breed_images/breed_images_screen.dart';
import 'package:base_flutter/presentation/dog_breeds/dog_breeds_screen.dart';
import 'package:base_flutter/presentation/fav/fav_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'app_route_names.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case AppRouteNames.dogBreedsScreenRoute:
        return PageTransition(
            type: PageTransitionType.fade,
            child: const DogBreedsScreen(
              pageRoute: AppRouteNames.dogBreedsScreenRoute,
            ));

      case AppRouteNames.breedImagesScreenRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final dogBreed = args['dog_breed'];

        return PageTransition(
            type: PageTransitionType.fade,
            child: BreedImagesScreen(
              pageRoute: AppRouteNames.breedImagesScreenRoute,
              dogBreed: dogBreed,
            ));

      case AppRouteNames.favScreenRoute:
        final args = settings.arguments as Map<String, dynamic>;
        final dogBreeds = args['dog_breeds'];

        return PageTransition(
            type: PageTransitionType.fade,
            child: FavScreen(
              dogBreeds: dogBreeds,
            ));

      default:
        return MaterialPageRoute(builder: (_) => Container());
    }
  }
}
