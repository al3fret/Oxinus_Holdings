import 'package:base_flutter/domain/entities/dog_breed.dart';
import 'package:base_flutter/domain/entities/base_api_response.dart';
import 'package:base_flutter/domain/entities/breed_image.dart';
import 'package:base_flutter/domain/repository/api_repository.dart';

import '../../domain/data_source/api_data_source.dart';

class ApiRepositoryImpl implements ApiRepository {
  final ApiDataSource apiDataSource;

  ApiRepositoryImpl({required this.apiDataSource});

  @override
  Future<BaseApiResponse<List<DogBreed>>> fetchDogBreeds() {
    return apiDataSource.fetchDogBreeds();
  }

  @override
  Future<BaseApiResponse<List<BreedImage>>?> fetchBreedImages(String breed) {
    return apiDataSource.fetchBreedImages(breed);
  }
}
