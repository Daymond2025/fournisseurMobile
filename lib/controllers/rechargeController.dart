import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constants/constantApp.dart';
import '../models/transactionModel.dart';
import '../models/transactionorderModel.dart';

class RechargeController extends GetxController {
  var montant = ''.obs;
  var operator = ''.obs;
  var numeroWave = ''.obs;
  Rx<List<TransactionModel>> transaction = Rx<List<TransactionModel>>([]);
  //Rx<List<TransactionOrder>> transactionOrder = Rx<List<TransactionOrder>>([]);
  final formKey = GlobalKey<FormState>();
  var waiting = true.obs;

  @override
  void onInit() {
    fetchTransaction();
    // fetchOrders(currentPage);
    super.onInit();
  }

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      // Changez Createpayement en createPayment
      EasyLoading.show(status: "Un instant...");
      // Assuming you have a URL for your API endpoint
      String apiUrl = AppConstants.recharge;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }
      print('object ${numeroWave.value} ${operator.value}');
      // Envoyer la requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
          // 'Content-Type': 'application/json', // Spécifiez le type de contenu
        },
        body: {
          'phone_number': numeroWave.value,
          'operator': operator.value,
          'amount': montant.value,
        },
      );

      if (response.statusCode == 200) {
        final data = response.body;
        final responseData = jsonDecode(data)['data'];
        final url =
            responseData['url']; // Assurez-vous que l'URL est dans la réponse
        print('$url');

        // Si la requête est réussie, convertissez les données JSON en liste d'objets MyModel

        if (await canLaunch(url!)) {
          await launch(url!);

          EasyLoading.dismiss();
          // showGetSnackBar(messageText: "Un enregistrement ajouté avec succès!");
          return;
        } else {
          throw 'Could not launch $url';
        }
      } else {
        EasyLoading.showSuccess(
            'Echèc, ${jsonDecode(response.body)['message']} ');
        //EasyLoading.showError('Failed to submit. Please try again.');
        // API call failed
        EasyLoading.dismiss();
        // Handle error, show a message, etc.
        print('Errorpays: ${response.statusCode}, ${response.body}');
        // Optionally, you can show an error message using EasyLoading.showError()
      }
      //EasyLoading.dismiss();
    }
  }

  Future<void> retraits() async {
    if (formKey.currentState!.validate()) {
      // Changez Createpayement en createPayment
      EasyLoading.show(status: "Un instant...");
      // Assuming you have a URL for your API endpoint
      String apiUrl = AppConstants.retrait;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }
      // Envoyer la requête POST
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
          // 'Content-Type': 'application/json', // Spécifiez le type de contenu
        },
        body: {
          'phone_number': numeroWave.value,
          'operator': operator.value,
          'amount': montant.value,
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Retrait validé avec succès');
      } else {
        //EasyLoading.showError('Failed to submit. Please try again.');
        // API call failed
        EasyLoading.showSuccess(
            'Echèc, ${jsonDecode(response.body)['message']} ');
        EasyLoading.dismiss();
        // Handle error, show a message, etc.
        print('Errorpays: ${response.statusCode}, ${response.body}');
        // Optionally, you can show an error message using EasyLoading.showError()
      }
      //EasyLoading.dismiss();
    }
  }

  Future<void> submitsolder(int id) async {
    if (formKey.currentState!.validate()) {
      // Changez Createpayement en createPayment
      EasyLoading.show(status: "Un instant...");
      // Assuming you have a URL for your API endpoint
      String apiUrl = AppConstants.baseUrl;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }
      // Envoyer la requête POST
      final response = await http.get(
        Uri.parse('$apiUrl/supplier/transaction/$id/pay'),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
          // 'Content-Type': 'application/json', // Spécifiez le type de contenu
        },
      );

      if (response.statusCode == 200) {
        final data = response.body;
        final responseData = jsonDecode(data)['data'];
        final url =
            responseData['url']; // Assurez-vous que l'URL est dans la réponse
        print('$url');

        // Si la requête est réussie, convertissez les données JSON en liste d'objets MyModel
      } else {
        //EasyLoading.showError('Failed to submit. Please try again.');
        // API call failed
        EasyLoading.dismiss();
        // Handle error, show a message, etc.
        print('Errorpays: ${response.statusCode}, ${response.body}');
        // Optionally, you can show an error message using EasyLoading.showError()
      }
      //EasyLoading.dismiss();
    }
  }

  Future<void> fetchTransaction() async {
    try {
      waiting(true);

      // Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }

      // Make the API request with token in headers
      final response = await http.get(
        Uri.parse(AppConstants.transaction),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('recharge @#####${response.body}');
      transaction.value.clear();
      waiting(false);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        print('rechargeabbb$jsonData');
        if (jsonData != null) {
          // Continue avec le mapping si jsonData n'est pas null
          transaction.value.clear();
          for (var item in jsonData) {
            transaction.value.add(TransactionModel.fromJson(item));
            //transactionOrder.value.add(TransactionOrder.fromJson(item));
          }
        } else {
          Get.snackbar("Error", "No data found in response");
        }
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access, please log in again.");
      } else {
        Get.snackbar("Error", "Failed to load comade: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      waiting(false);
    }
  }
}
