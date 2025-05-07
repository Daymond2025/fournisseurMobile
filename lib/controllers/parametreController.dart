import 'package:daymond_dis/models/categorieModel.dart';
import 'package:daymond_dis/models/villeModel.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constantApp.dart';
import '../models/statemodel.dart';

class ConditionController extends GetxController {
  Rx<List<StateParams>> conditionList = Rx<List<StateParams>>([]);
  Rx<List<CatParams>> catList = Rx<List<CatParams>>([]);
  Rx<List<VilleParams>> villeList = Rx<List<VilleParams>>([]);
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchConditions();
    fetchCat();
    fetchVilles();
    super.onInit();
  }

  Future<void> fetchConditions() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(AppConstants.parametre));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];
        conditionList.value.clear();
        for (var item in jsonData) {
          conditionList.value.add(StateParams.fromJson(item));
        }

        //conditionList.assignAll(conditions);
      } else {
        // Handle error
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCat() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(AppConstants.categories));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];
        catList.value.clear();
        for (var item in jsonData) {
          catList.value.add(CatParams.fromJson(item));
        }

        //conditionList.assignAll(conditions);
      } else {
        // Handle error
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchVilles() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          "https://v2.daymondboutique.com/api/v2/params/data/offline?option=city"));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body)['data'];
        // print(jsonData);
        villeList.value.clear();
        for (var item in jsonData) {
          villeList.value.add(VilleParams.fromJson(item));
        }

        //conditionList.assignAll(conditions);
      } else {
        // Handle error
      }
    } finally {
      isLoading(false);
    }
  }
}
