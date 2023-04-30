import 'package:base_flutter/data/data_source/api_data_source_impl.dart';
import 'package:base_flutter/data/repository/shared_preferences_repository_impl.dart';
import 'package:base_flutter/domain/repository/api_repository.dart';
import 'package:base_flutter/network/http_api_client.dart';
import 'package:base_flutter/routes/app_route_names.dart';
import 'package:base_flutter/routes/route_generator.dart';
import 'package:base_flutter/services/ConnectivityService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/app_bloc/app_bloc.dart';
import 'domain/repository/shared_preferences_repository.dart';
import 'enums/connectivity_status.dart';
import 'utils/app_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  await FlutterStatusbarcolor.setStatusBarColor(AppColors.colorOrange);
  if (useWhiteForeground(AppColors.colorOrange)) {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
  } else {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  await FlutterStatusbarcolor.setNavigationBarColor(AppColors.colorOrange);
  if (useWhiteForeground(AppColors.colorOrange)) {
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
  } else {
    FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
  }

  SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferencesRepositoryImpl(
          preferences: await SharedPreferences.getInstance());

  ApiRepository apiRepository =
      ApiDataSourceImpl(httpApiClient: HttpApiClient());
  runApp(MyAppBloc(
    apiRepository: apiRepository,
    sharedPreferencesRepository: sharedPreferencesRepository,
  ));
}

class MyAppBloc extends StatelessWidget {
  final ApiRepository apiRepository;
  final SharedPreferencesRepository sharedPreferencesRepository;

  const MyAppBloc(
      {super.key,
      required this.apiRepository,
      required this.sharedPreferencesRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: AppBloc(
          apiRepository: apiRepository,
          pageRoute: AppRouteNames.dogBreedsScreenRoute),
      child: MyAppProvider(
          sharedPreferencesRepository: sharedPreferencesRepository),
    );
  }
}

class MyAppProvider extends StatelessWidget {
  final SharedPreferencesRepository sharedPreferencesRepository;

  const MyAppProvider({super.key, required this.sharedPreferencesRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<SharedPreferencesRepository>(
          create: (context) => sharedPreferencesRepository),
      StreamProvider<ConnectivityStatus>(
        initialData: ConnectivityStatus.wifi,
        create: (context) =>
            ConnectivityService().connectionStatusController.stream,
      ),
    ], child: const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRouteNames.dogBreedsScreenRoute,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
    );
  }
}
