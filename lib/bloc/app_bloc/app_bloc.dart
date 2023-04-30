import 'package:base_flutter/domain/repository/api_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  ApiRepository apiRepository;
  String pageRoute;

  AppBloc({required this.apiRepository, required this.pageRoute})
      : super(AppStartState(pageRoute: pageRoute)) {
    on<AppEvent>(_onFetchData);
  }

  void _onFetchData(AppEvent event, Emitter<AppState> emit) async {
    emit(AppLoadingAppState(pageRoute: event.pageRoute));

    try {
      Object? response;

      /// Handel All Response Issue
      switch (event.runtimeType) {
        case FetchDogBreedAppEvent:
          event as FetchDogBreedAppEvent;
          response = await apiRepository.fetchDogBreeds();
          break;
        case FetchBreedImagesAppEvent:
          event as FetchBreedImagesAppEvent;
          response = await apiRepository.fetchBreedImages(event.breed);
          break;
      }

      emit(AppLoadedAppState(response: response!, pageRoute: event.pageRoute));
    } catch (e) {
      /// Return Error State
      emit(AppErrorAppState(errorMessage: '$e', pageRoute: event.pageRoute));
    }
  }
}
