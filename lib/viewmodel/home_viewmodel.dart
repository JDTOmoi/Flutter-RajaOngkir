import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/response/api_response.dart';
import 'package:flutter_application_2/model/costs/costs.dart';
import 'package:flutter_application_2/model/model.dart';
import 'package:flutter_application_2/repository/home_repository.dart';

class HomeViewmodel with ChangeNotifier {
  final _homeRepo = HomeRepository();
  ApiResponse<List<Province>> provinceList = ApiResponse.loading();
  ApiResponse<List<City>> cityList = ApiResponse.loading();
  ApiResponse<List<Province>> provinceListDest = ApiResponse.loading();
  ApiResponse<List<City>> cityListDest = ApiResponse.loading();
  ApiResponse<List<Costs>> costsList = ApiResponse.loading();

  setProvinceList(ApiResponse<List<Province>> response) {
    provinceList = response;
    notifyListeners();
  }

  setCityList(ApiResponse<List<City>> response) {
    cityList = response;
    notifyListeners();
  }

  setCityListDest(ApiResponse<List<City>> response) {
    cityListDest = response;
    notifyListeners();
  }

  setCostsList(ApiResponse<List<Costs>> response) {
    costsList = response;
    notifyListeners();
  }

  Future<void> getProvinceList() async {
    setProvinceList(ApiResponse.loading());
    _homeRepo.fetchProvinceList().then((value) {
      setProvinceList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProvinceList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCityList(var provId) async {
    setCityList(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCityListDest(var provId) async {
    setCityListDest(ApiResponse.loading());
    _homeRepo.fetchCityList(provId).then((value) {
      setCityListDest(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCityListDest(ApiResponse.error(error.toString()));
    });
  }

  Future<void> getCostsList(
      String orgnCityId, String destCityId, int weight, String courier) async {
    setCostsList(ApiResponse.loading());
    _homeRepo
        .fetchCostsList(orgnCityId, destCityId, weight, courier)
        .then((value) {
      setCostsList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCostsList(ApiResponse.error(error.toString()));
    });
  }
}
