abstract class AppEvent {
  final String pageRoute;

  AppEvent({required this.pageRoute});
}

class FetchDogBreedAppEvent extends AppEvent {
  FetchDogBreedAppEvent({required String pageRoute})
      : super(pageRoute: pageRoute);
}

class FetchBreedImagesAppEvent extends AppEvent {
  final String breed;

  FetchBreedImagesAppEvent({
    required this.breed,
    required String pageRoute,
  }) : super(pageRoute: pageRoute);
}
