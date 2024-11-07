import 'dart:convert';
import 'package:daymond_dis/constants/constantApp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/phoneModel.dart';

class PhoneDataController extends GetxController {
  // Utiliser Rxn pour permettre la nullabilité
  var isLoading = false.obs;
  Rx<List<PhoneData>> phoneData = Rx<List<PhoneData>>([]);
  // Méthode pour récupérer les données de l'API
  Future<void> fetchPhoneData() async {
    var url = AppConstants.numbers;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      isLoading(true); // Démarrer le chargement
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Optional if you have authentication
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null) {
          // Parcours et ajout des commandes à la liste
          for (var item in data) {
            phoneData.value.add(PhoneData.fromJson(item));
          }
        }
  // Assigner les données récupérées
        print('Phone data: ${phoneData.value}');
      } else {
        print(
            'Erreur lors de la récupération des données: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur: $e');
    } finally {
      isLoading(false); // Arrêter le chargement
    }
  }

  // Méthode pour accéder aux informations de phoneData
  /* PhoneData? getPhoneData() {
    return phoneData.value;
  } */
}
