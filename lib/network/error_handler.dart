import 'package:base_flutter/domain/entities/base_api_response.dart';
import 'package:http/http.dart' as http;


class ErrorHandler {
  static Future<BaseApiResponse> handleErrors(http.Response response) async {
    late String errorMessage;
    try {
      errorMessage = 'Error occurred: ${response.reasonPhrase}';
    } catch (e) {
      errorMessage = 'Error occurred: $e';
    }

    return BaseApiResponse(status: "error", errorMessage: errorMessage);
  }
}
