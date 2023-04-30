import 'package:equatable/equatable.dart';

class BreedImage  extends Equatable{
  final String imageUrl;
   bool isFav;

  BreedImage({required this.imageUrl, required this.isFav});

  @override
  List<Object?> get props => [imageUrl, isFav];
}

class BreedImageMapper {
  static List<BreedImage> map(dynamic data) {
    final List<String> images =
        List<String>.from(data['message'].map((image) => image));

    return images
        .map((imageUrl) => BreedImage(imageUrl: imageUrl, isFav: false))
        .toList();
  }
}
