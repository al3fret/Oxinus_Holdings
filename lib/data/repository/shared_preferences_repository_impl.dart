import 'dart:convert';

import 'package:base_flutter/domain/entities/fav_list_item.dart';
import 'package:base_flutter/domain/repository/shared_preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  final SharedPreferences preferences;

  static const _key = 'fav_list_item';

  SharedPreferencesRepositoryImpl({required this.preferences});

  @override
  Future<List<FavListItem>> getItems() async {
    final itemsJson = preferences.getString(_key);
    if (itemsJson != null) {
      final items = jsonDecode(itemsJson) as List<dynamic>;
      return items.map((item) => FavListItem.fromJson(item)).toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> addAllItems(List<FavListItem> items) async {
    final itemsJson = jsonEncode(items.map((item) => item.toJson()).toList());
    await preferences.setString(_key, itemsJson);
  }

  @override
  Future<void> onFavTap(FavListItem favListItem) async {
    var items = await getItems();


    bool isExist = false;
    for(int i=0;i<items.length;i++){

      if(items[i].imageUrl == favListItem.imageUrl &&
      items[i].breed == favListItem.breed){

        isExist = true;
        items.removeAt(i);
      }
    }

    if (!isExist) {
      items.add(favListItem);
    }

    addAllItems(items);
  }

  @override
  Future<bool> isFav(FavListItem favListItem) async {
    var items = await getItems();
    bool isExist = false;
    for(int i=0;i<items.length;i++){

      if(items[i].imageUrl == favListItem.imageUrl &&
          items[i].breed == favListItem.breed){

        isExist = true;
      }
    }
    return isExist;
  }
}
