import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/constantApp.dart';
import '../controllers/GetUsercontroller.dart';
import '../models/api_response.dart';
import '../models/usermodel.dart';

Future<ApiResponse> getUserDetail() async {
  GetUserController authController = Get.put(GetUserController());

  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(AppConstants.userURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    print(';getUserDetail;;;;;;;;;;;;;;;;;;;;;t ${response.body}');
    final data = response.body;
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body)['data']);
        authController
            .updateUserInfo(User.fromJson(jsonDecode(response.body)['data']));
        break;
      case 401:
        apiResponse.error = AppConstants.unauthorized;
        break;
      default:
        apiResponse.error = AppConstants.somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = AppConstants.serverError;
  }
  return apiResponse;
}

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
