import 'dart:convert';

import 'package:flutter_application_2/data/network/network_api_services.dart';
import 'package:flutter_application_2/model/costs/costs.dart';
import 'package:flutter_application_2/model/model.dart';
import 'package:flutter_application_2/shared/shared.dart';
import 'package:http/http.dart' as http;

class HomeRepository {
  final _apiServices = NetworkApiServices();

  Future<List<Province>> fetchProvinceList() async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/province');
      List<Province> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => Province.fromJson(e))
            .toList();
      }
      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<List<City>> fetchCityList(var provId) async {
    try {
      dynamic response = await _apiServices.getApiResponse('/starter/city');
      List<City> result = [];

      if (response['rajaongkir']['status']['code'] == 200) {
        result = (response['rajaongkir']['results'] as List)
            .map((e) => City.fromJson(e))
            .toList();
      }

      List<City> selectedCities = [];
      for (var c in result) {
        if (c.provinceId == provId) {
          selectedCities.add(c);
        }
      }

      return selectedCities;
    } catch (e) {
      throw e;
    }
  }

  Future<List<Costs>> fetchCostsList(
      String orgnCityId, String destCityId, int weight, String courier) async {
    try {
      //dynamic response = await _apiServices.getApiResponse('/starter/cost');
      Uri url = Uri.parse('https://api.rajaongkir.com/starter/cost');
      final response = await http.post(url, body: {
        "origin": "$orgnCityId",
        "destination": "$destCityId",
        "weight": "$weight",
        "courier": "$courier"
      }, headers: {
        'Content-type': 'application/x-www-form-urlencoded',
        'key': Const.apiKey,
      });

      var data = json.decode(response.body) as Map<String, dynamic>;

      List<Costs> result = [];

      if (data['rajaongkir']['status']['code'] == 200) {
        result = (data['rajaongkir']['results'][0]['costs'] as List)
            .map((e) => Costs.fromJson(e))
            .toList();
      }

      return result;
    } catch (e) {
      throw e;
    }
  }
}
