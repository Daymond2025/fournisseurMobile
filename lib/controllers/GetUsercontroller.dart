import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    }
  }
}
