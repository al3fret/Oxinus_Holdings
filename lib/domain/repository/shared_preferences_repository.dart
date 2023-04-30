import 'package:base_flutter/domain/entities/fav_list_item.dart';

abstract class SharedPreferencesRepository {
  Future<List<FavListItem>> getItems();

  Future<void> addAllItems(List<FavListItem> items);

  Future<void> onFavTap(FavListItem favListItem);
  Future<bool> isFav(FavListItem favListItem);
}
