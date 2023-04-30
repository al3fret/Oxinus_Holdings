import 'package:base_flutter/domain/entities/base_api_response.dart';
import 'package:base_flutter/domain/repository/api_repository.dart';
import 'package:base_flutter/network/http_api_client.dart';

import '../../domain/entities/dog_breed.dart';
import '../../domain/entities/breed_image.dart';
import '../../network/error_handler.dart';

class ApiDataSourceImpl implements ApiRepository {
  final HttpApiClient httpApiClient;

  ApiDataSourceImpl({required this.httpApiClient});

  @override
  Future<BaseApiResponse<List<DogBreed>>?> fetchDogBreeds() async {
    final response = await httpApiClient.get("breeds/list/all");

    if (response.statusCode == 200) {
      final List<DogBreed> breeds = DogBreedsMapper.map(response.data);
      return BaseApiResponse(status: response.data['status'], message: breeds);
    } else {
      return ErrorHandler.handleErrors(response.data)
          as BaseApiResponse<List<DogBreed>>?;
    }
  }



  @override
  Future<BaseApiResponse<List<BreedImage>>?> fetchBreedImages(String breed) async {
    final response = await httpApiClient.get('breed/$breed/images');
    if (response.statusCode == 200) {

      final List<BreedImage> dogImages = BreedImageMapper.map(response.data);

      return BaseApiResponse(status: response.data['status'], message: dogImages);

    } else {
      return ErrorHandler.handleErrors(response.data)
      as BaseApiResponse<List<BreedImage>>?;
    }
  }

}
