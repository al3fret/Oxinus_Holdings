import 'package:base_flutter/domain/entities/drop_down_item.dart';
import 'package:equatable/equatable.dart';

class FavListItem extends DropdownItem  with EquatableMixin  {
  final String imageUrl;
  final String breed;

  FavListItem({
    required this.imageUrl,
    required this.breed,
  }) : super(dropDownId: breed, dropDownValue: breed);

  factory FavListItem.fromJson(Map<String, dynamic> json) {
    return FavListItem(
      imageUrl: json['image_url'],
      breed: json['breed'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image_url': imageUrl,
        'breed': breed,
      };


@override
List<Object?> get props => [imageUrl, breed];
}
