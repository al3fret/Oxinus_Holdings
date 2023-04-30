import 'package:base_flutter/bloc/app_bloc/app_event.dart';
import 'package:base_flutter/domain/entities/base_api_response.dart';
import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/domain/entities/fav_list_item.dart';
import 'package:base_flutter/domain/repository/shared_preferences_repository.dart';
import 'package:base_flutter/enums/connectivity_status.dart';
import 'package:base_flutter/presentation/breed_images/content/breed_images_grid_view.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/widgets/empty_page.dart';
import 'package:base_flutter/widgets/error_page.dart';
import 'package:base_flutter/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../bloc/app_bloc/app_bloc.dart';
import '../../../bloc/app_bloc/app_state.dart';
import '../../domain/entities/breed_image.dart';
import '../../utils/app_toast.dart';
import 'content/breed_images_app_bar.dart';

class BreedImagesScreen extends StatefulWidget {
  final DogBreed dogBreed;
  final String pageRoute;

  const BreedImagesScreen(
      {Key? key, required this.dogBreed, required this.pageRoute})
      : super(key: key);

  @override
  State<BreedImagesScreen> createState() => _BreedImagesScreenState();
}

class _BreedImagesScreenState extends State<BreedImagesScreen> {
  List<FavListItem> _sharedPreferencesItems = [];

  @override
  void initState() {
    BlocProvider.of<AppBloc>(context).add(FetchBreedImagesAppEvent(
        breed: widget.dogBreed.name, pageRoute: widget.pageRoute));

    var sharedPreferencesRepository =
        Provider.of<SharedPreferencesRepository>(context, listen: false);

    sharedPreferencesRepository
        .getItems()
        .then((value) => {_sharedPreferencesItems = value});

    super.initState();
  }

  _callApi() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityStatus connectivityStatus =
          Provider.of<ConnectivityStatus>(context, listen: true);

      if (connectivityStatus == ConnectivityStatus.offline) {
        showToastNoConnectionError();
      } else {
        BlocProvider.of<AppBloc>(context).add(FetchBreedImagesAppEvent(
            breed: widget.dogBreed.name, pageRoute: widget.pageRoute));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var connectionStatus =
        Provider.of<ConnectivityStatus>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        appBar: breedImagesAppBar(widget.dogBreed.name),
        backgroundColor: AppColors.colorWhite,
        body: BlocBuilder<AppBloc, AppState>(
            builder: (BuildContext context, state) {
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
    );
  }

  _onTapFav(BreedImage breedImage) {
    setState(() {
      if (_isBreedImageExistInSharedPreferences(breedImage)) {
        _removeBreedImageFromSharedPreferences(breedImage);
      } else {
        _sharedPreferencesItems.add(FavListItem(
            imageUrl: breedImage.imageUrl, breed: widget.dogBreed.name));
      }
    });

    var sharedPreferencesRepository =
        Provider.of<SharedPreferencesRepository>(context, listen: false);

    sharedPreferencesRepository.onFavTap(FavListItem(
        imageUrl: breedImage.imageUrl, breed: widget.dogBreed.name));
  }

  Widget _handelResponse(
    Object response,
  ) {
    if (response is BaseApiResponse<List<BreedImage>>) {
      var items = response.message!;

      for (int i = 0; i < items.length; i++) {
        items[i].isFav = _isBreedImageExistInSharedPreferences(items[i]);
      }

      if (items.isEmpty) {
        return const EmptyPage();
      } else {
        return breedImagesGridView(items, _onTapFav, _callApi);
      }
    }

    return ErrorPage(onPressed: _callApi, errorMessage: "An unexpected error");
  }

  bool _isBreedImageExistInSharedPreferences(BreedImage breedImage) {
    bool isExist = false;
    for (int i = 0; i < _sharedPreferencesItems.length; i++) {
      if (breedImage.imageUrl == _sharedPreferencesItems[i].imageUrl &&
          widget.dogBreed.name == _sharedPreferencesItems[i].breed) {
        isExist = true;
      }
    }
    return isExist;
  }

  void _removeBreedImageFromSharedPreferences(BreedImage breedImage) {
    for (int i = 0; i < _sharedPreferencesItems.length; i++) {
      if (breedImage.imageUrl == _sharedPreferencesItems[i].imageUrl &&
          widget.dogBreed.name == _sharedPreferencesItems[i].breed) {
        _sharedPreferencesItems.removeAt(i);
      }
    }
  }
}
