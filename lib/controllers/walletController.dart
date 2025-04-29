import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constantApp.dart';
import '../models/walletmodel.dart';

class WalletController extends GetxController {
  var wallet = Rxn<Wallet>();

  var dash = Rxn<FinancialData>(); // Reactive nullable wallet
  var isLoading = false.obs;
  var waiting = false.obs;
  RxInt isAdmin = 0.obs;
  RxString roles = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadIsAdmin();
    fetchdash();
  }

  void loadIsAdmin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    isAdmin.value = pref.getInt('admin') ?? 0;
    roles.value = pref.getString('role') ?? '';
  }

  Future<void> fetchWalletData() async {
    try {
      isLoading(true);

      // Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }

      // Make the API request
      final response = await http.get(
        Uri.parse(AppConstants.walletbyuser),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('wallet value $jsonData');
        try {
          wallet.value = Wallet.fromJson(jsonData);
        } catch (e) {
          print("Erreur wallet : $e");
        }
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access, please log in again.");
      } else {
        Get.snackbar(
            "Error", "Failed to load wallet data: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchdash() async {
    print("==api fetch dash==");
    try {
      waiting(true);

      // Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }

      // Make the API request
      final response = await http.get(
        Uri.parse(AppConstants.dashboard),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("==api dashboard ${response.statusCode}");
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print('api dash == $jsonData');
        try {
          dash.value = FinancialData.fromJson(jsonData);
        } catch (e, stacktrace) {
          print(
              "api dash Erreur lors de la conversion du JSON en FinancialData : $e");
          print("api dash Stacktrace : $stacktrace");
        }
        print('api dash value ${dash.value}');
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access, please log in again.");
      } else {
        Get.snackbar(
            "Error", "Failed to load wallet data: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      waiting(false);
    }
  }
}
