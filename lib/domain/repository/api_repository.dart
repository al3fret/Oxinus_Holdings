import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/domain/entities/base_api_response.dart';

import '../entities/breed_image.dart';

abstract class ApiRepository {
  Future<BaseApiResponse<List<DogBreed>>?> fetchDogBreeds();

  Future<BaseApiResponse<List<BreedImage>>?> fetchBreedImages(String breed);
}
