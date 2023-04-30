import 'package:base_flutter/domain/entities/drop_down_item.dart';
import 'package:equatable/equatable.dart';

class DogBreed  extends DropdownItem with EquatableMixin  {
  final String name;
  final List<SubBreed> subBreeds;

   DogBreed({required this.name, required this.subBreeds}):
         super(dropDownId: name, dropDownValue: name);

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    final List<SubBreed> subBreeds = [];
    if (json['subBreeds'] != null) {
      for (var subBreed in json['subBreeds']) {
        subBreeds.add(SubBreed(name: subBreed));
      }
    }
    return DogBreed(
      name: json['name'],
      subBreeds: subBreeds,
    );
  }

  @override
  List<Object?> get props => [name, subBreeds];

}

class SubBreed extends Equatable{
  final String name;

  const SubBreed({required this.name});

  factory SubBreed.fromJson(Map<String, dynamic> json) {
    return SubBreed(
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [name];
}

class DogBreedsMapper {
  static List<DogBreed> map(dynamic data)  {


    final List<DogBreed> breeds = List<DogBreed>.from(
        data['message'].keys.map((breed) => DogBreed.fromJson({
          'name': breed,
          'subBreeds': data['message'][breed]
        })));
    return breeds;
  }
}

