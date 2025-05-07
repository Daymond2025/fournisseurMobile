import 'dart:convert';
import 'package:daymond_dis/constants/constantApp.dart';
import 'package:daymond_dis/models/shopmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShopController extends GetxController {
  var isLoading = false.obs;
  var shopList = <Shops>[].obs;

  // Fonction pour récupérer les données depuis l'API
  Future<void> fetchShops() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }
      final response = await http.get(
        Uri.parse(AppConstants.shop), // Remplace par ton endpoint API
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        for (var item in jsonData) {
          shopList.add(Shops.fromJson(item));
          //transactionOrder.value.add(TransactionOrder.fromJson(item));
        }
      } else {
        Get.snackbar("Erreur",
            "Échec de récupération des données");
      }
    } catch (e) {
      print('object$e');
      Get.snackbar("Erreur", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchShops(); // Appeler automatiquement la fonction à l'initialisation du contrôleur
  }
}
