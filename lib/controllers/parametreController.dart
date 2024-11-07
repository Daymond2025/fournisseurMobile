import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/constantApp.dart';
import '../models/statemedel.dart';

class ConditionController extends GetxController {
  Rx<List<StateParams>> conditionList = Rx<List<StateParams>>([]);
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchConditions();
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
}
