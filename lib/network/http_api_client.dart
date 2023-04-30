import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpApiClient {
  final _dio = Dio(BaseOptions(
    headers: {
      HttpHeaders.cacheControlHeader: 'no-cache', // set cache-control to no-cache
    },
  ));
  final String _baseUrl = "https://dog.ceo/api/";


  HttpApiClient() {
    _dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
  }

  Future<Response> get(String path) async {
    return _dio.get('$_baseUrl$path');
  }

}
