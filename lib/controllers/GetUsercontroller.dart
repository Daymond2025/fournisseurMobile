import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
import '../models/usermodel.dart';
import '../services/userService .dart';
import 'LoginController.dart';

class GetUserController extends GetxController {
  User? globalUserInfo;
  var user = Rxn<User>(); // Observable pour stocker l'utilisateur
  var isLoading = false.obs; // Observable pour suivre le chargement
  //final LoginController loginController = Get.put(LoginController());

  Future<void> updateUserInfo(User data) async {
    globalUserInfo = data;
    update();
  }

  Future<void> getUserInfo() async {
    ApiResponse response = await getUserDetail();
    if (response.error == null) {
      globalUserInfo ??= response.data as User;
      // setUserImage(globalUserInfo?.image);
      update();
      // Convertir l'objet User en JSON et sauvegarder dans SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(
          response.data); // Assure-toi que User a une méthode `toJson`
      await prefs.setString('user_info', userJson);
    }
  }
}
