import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState({required this.pageRoute});

  final String pageRoute;

  @override
  List<Object> get props => [pageRoute];
}

class AppStartState extends AppState {
  const AppStartState({required String pageRoute})
      : super(pageRoute: pageRoute);

  @override
  List<Object> get props => [pageRoute];
}

class AppLoadingAppState extends AppState {
  const AppLoadingAppState({required String pageRoute})
      : super(pageRoute: pageRoute);

  @override
  List<Object> get props => [pageRoute];
}

class AppLoadedAppState<T> extends AppState {
  final Object response;

  const AppLoadedAppState({required this.response, required String pageRoute})
      : super(pageRoute: pageRoute);

  @override
  List<Object> get props => [response, pageRoute];
}

class AppErrorAppState extends AppState {
  final String errorMessage;

  const AppErrorAppState(
      {required this.errorMessage, required String pageRoute})
      : super(pageRoute: pageRoute);

  @override
  List<Object> get props => [errorMessage, pageRoute];
}
