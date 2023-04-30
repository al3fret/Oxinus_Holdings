import 'package:base_flutter/domain/entities/drop_down_item.dart';
import 'package:base_flutter/domain/entities/fav_list_item.dart';
import 'package:base_flutter/presentation/fav/content/fav_grid_view.dart';
import 'package:base_flutter/utils/app_colors.dart';
import 'package:base_flutter/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/dog_breed.dart';
import '../../domain/repository/shared_preferences_repository.dart';
import '../../widgets/custom_drop_down.dart';
import '../breed_images/content/breed_images_app_bar.dart';

class FavScreen extends StatefulWidget {
  final List<DogBreed> dogBreeds;

  const FavScreen({Key? key, required this.dogBreeds}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  List<FavListItem> _sharedPreferencesItems = [];
  final List<FavListItem> _filteredFavItems = [];
  late DogBreed _allDogBreed;
  late List<DogBreed> _dogBreedItems;
  late DogBreed _selectedDogBreed;

  @override
  void initState() {
    _allDogBreed = DogBreed(name: "all", subBreeds: []);

    _dogBreedItems = [_allDogBreed];
    _dogBreedItems.addAll(widget.dogBreeds);
    var sharedPreferencesRepository =
        Provider.of<SharedPreferencesRepository>(context, listen: false);

    sharedPreferencesRepository.getItems().then((value) => {
          setState(() {
            _sharedPreferencesItems = value;
            _selectedDogBreed = _allDogBreed;
            _filteredFavItems.addAll(value);
          })
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: breedImagesAppBar("Favorite"),
          backgroundColor: AppColors.colorWhite,
          body: Column(
            children: [
              CustomDropDownButton(
                initialValue: _dogBreedItems[0],
                items: _dogBreedItems,
                onChanged: (dropdownItem) {
                  _selectedDogBreed = _getSelectedDogBreed(dropdownItem)!;
                  _filterFavItems();
                },
              ),
              Expanded(child: _handelPage())
            ],
          )),
    );
  }

  Widget _handelPage() {
    return _filteredFavItems.isEmpty
        ? const EmptyPage()
        : favGridView(_filteredFavItems, _onTapFav);
  }

  _onTapFav(FavListItem favListItem) {
    setState(() {
      _removeBreedImageFromSharedPreferences(favListItem);
    });

    var sharedPreferencesRepository =
        Provider.of<SharedPreferencesRepository>(context, listen: false);

    sharedPreferencesRepository.onFavTap(favListItem);
  }

  void _removeBreedImageFromSharedPreferences(FavListItem favListItem) {
    for (int i = 0; i < _sharedPreferencesItems.length; i++) {
      if (favListItem.imageUrl == _sharedPreferencesItems[i].imageUrl &&
          favListItem.breed == _sharedPreferencesItems[i].breed) {
        _sharedPreferencesItems.removeAt(i);
      }
    }

    _filterFavItems();
  }

  DogBreed? _getSelectedDogBreed(DropdownItem dropdownItem) {
    for (DogBreed dogBreed in _dogBreedItems) {
      if (dogBreed.dropDownId == dropdownItem.dropDownId &&
          dogBreed.dropDownValue == dropdownItem.dropDownValue) {
        return dogBreed;
      }
    }
    return null;
  }

  _filterFavItems() {
    List<FavListItem> items = [];

    if (_selectedDogBreed == _allDogBreed) {
      items.addAll(_sharedPreferencesItems);
    } else {
      for (FavListItem fav in _sharedPreferencesItems) {
        if (fav.breed == _selectedDogBreed.name) {
          items.add(fav);
        }
      }
    }
    setState(() {
      _filteredFavItems.clear();
      _filteredFavItems.addAll(items);
    });
  }
}
