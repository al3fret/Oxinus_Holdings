import 'package:base_flutter/bloc/app_bloc/app_event.dart';
import 'package:base_flutter/domain/entities/base_api_response.dart';
import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/presentation/dog_breeds/content/dog_breeds_grid_view.dart';
import 'package:base_flutter/routes/app_route_names.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/widgets/empty_page.dart';
import 'package:base_flutter/widgets/error_page.dart';
import 'package:base_flutter/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/app_bloc/app_state.dart';
import '../../enums/connectivity_status.dart';
import '../../utils/app_toast.dart';
import 'content/dog_breeds_app_bar.dart';

class DogBreedsScreen extends StatefulWidget {
  final String pageRoute;

  const DogBreedsScreen({Key? key, required this.pageRoute}) : super(key: key);

  @override
  State<DogBreedsScreen> createState() => _DogBreedsScreenState();
}

class _DogBreedsScreenState extends State<DogBreedsScreen> {
  List<DogBreed> _dogBreeds = [];

  @override
  void initState() {
    BlocProvider.of<AppBloc>(context)
        .add(FetchDogBreedAppEvent(pageRoute: widget.pageRoute));
    super.initState();
  }

  _callApi() {
    ConnectivityStatus connectivityStatus =
        Provider.of<ConnectivityStatus>(context, listen: false);

    if (connectivityStatus == ConnectivityStatus.offline) {
      showToastNoConnectionError();
    } else {
      BlocProvider.of<AppBloc>(context)
          .add(FetchDogBreedAppEvent(pageRoute: widget.pageRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus =
        Provider.of<ConnectivityStatus>(context, listen: true);

    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop();
        } else {
          // Android back button hack
          SystemNavigator.pop();
        }
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: dogBreedsAppBar(_goToFavPage),
          backgroundColor: AppColors.colorWhite,
          body: BlocBuilder<AppBloc, AppState>(
              buildWhen: (previousState, currentState) {
            return previousState != currentState &&
                currentState.pageRoute == widget.pageRoute;
          }, builder: (BuildContext context, state) {
            print("Biladasdasds");

            if (state is AppLoadingAppState) {
              return const LoadingPage();
            }

            if (state is AppLoadedAppState) {
              return _handelResponse(state.response);
            }

            if (state is AppErrorAppState) {
              return ErrorPage(
                  onPressed: () {
                    _callApi();
                  },
                  errorMessage: connectionStatus == ConnectivityStatus.offline
                      ? 'Please check your internet connection'
                      : state.errorMessage);
            }
            return Container();
          }),
        ),
      ),
    );
  }

  void _goToBreedImagesPage(DogBreed dogBreed) {
    Navigator.pushNamed(context, AppRouteNames.breedImagesScreenRoute,
        arguments: {'dog_breed': dogBreed});
  }

  void _goToFavPage() {
    Navigator.pushNamed(context, AppRouteNames.favScreenRoute,
        arguments: {'dog_breeds': _dogBreeds});
  }

  Widget _handelResponse(Object response) {
    if (response is BaseApiResponse<List<DogBreed>>) {
      var items = response.message!;

      _dogBreeds = items;
      if (items.isEmpty) {
        return const EmptyPage();
      } else {
        return dogBreedsGridView(items, _goToBreedImagesPage, _callApi);
      }
    }

    return ErrorPage(onPressed: _callApi, errorMessage: "An unexpected error");
  }
}
