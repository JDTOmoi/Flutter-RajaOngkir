import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_application_2/data/app_exception.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/data/network/base_api_services.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future getApiResponse(String endpoint) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.https(Const.baseUrl, endpoint), headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
        'key': Const.apiKey,
      });
      responseJson = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on FetchDataException {
      throw FetchDataException('');
    } on TimeoutException {
      throw TimeoutException('Network request timed out!');
    }
    return responseJson;
  }

  @override
  Future postApiResponse(url, data) {
    // TODO: implement postApiResponse
    throw UnimplementedError();
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while communicating with server');
    }
  }
}
