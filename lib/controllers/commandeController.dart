import 'dart:convert';

import 'package:daymond_dis/screens/auth/loginScreen.dart';
import 'package:daymond_dis/screens/newScreens/connexion/connexion_widget.dart';
import 'package:daymond_dis/screens/views/detailNeworderScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/constantApp.dart';
import '../models/commandeModel.dart';
import '../models/commandemodels.dart';
import '../models/order_table.dart';
import '../screens/views/commande/commandeView.dart';
import '../screens/views/homeScreen.dart';

class OrderController extends GetxController {
  var iswaiting = true.obs;
  RxString selectedFilter = 'En attente'.obs;
  var orderList = <Order>[].obs;
  //Rx<List<>> orderList = Rx<List<Order>>([]);
  var currentPage = 1.obs;
  var lastPage = 1.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCommande(currentPage.value);
  }

  final int itemsPerPage = 20;
  Future<void> fetchCommande(int page) async {
    try {
      // Mettre iswaiting à true pour indiquer que le chargement commence
      iswaiting(true);

      // Récupérer le token à partir de SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Erreur", "Token non trouvé");
        return; // Retourne une liste vide en cas d'absence de token
      }

      // Formater correctement l'URL avec les paramètres
      final response = await http.get(
        Uri.parse('${AppConstants.order}?page=$page'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('Response body: ${response.body}');

      // Gérer la réponse de l'API
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print("les orders ${jsonData['data']}");
        List<Order> fetchedProducts = (jsonData['data'] as List)
            .map((productData) => Order.fromJson(productData))
            .toList();
        print("====ORDER SUCCESS===");
        orderList.clear();
        orderList.assignAll(fetchedProducts);
        currentPage.value = jsonData['meta']['current_page'];
        lastPage.value = jsonData['meta']['last_page'];
        print('Data reçue: $jsonData');
      } else if (response.statusCode == 401) {
        Get.offAll(ConnexionWidget());
        Get.snackbar(
            "Erreur", "Accès non autorisé, veuillez vous reconnecter.");
      } else {
        Get.snackbar("Erreur",
            "Echec du chargement des commandes: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      print("====ORDER ERROR===");
      Get.snackbar("Erreur", e.toString());
    } finally {
      iswaiting(false); // Terminer l'état de chargement
    }

    // Retourner la liste des commandes
  }

  void goToPage(int page) {
    if (page > 0 && page <= lastPage.value) {
      fetchCommande(page);
    }
  }

  Future<void> updateOrderStatus(
      int orderId, String newStatus, String? raison) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }
      var url = AppConstants.updateStatus;
      var response = await http.put(
        Uri.parse('$url/$orderId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String?>{
          'status': newStatus,
          'params': raison ?? null,
        }),
      );

      if (response.statusCode == 200) {
        // Afficher un message de succès
        Get.snackbar('Succès', 'Le statut a été mis à jour avec succès',
            backgroundColor: Colors.green, colorText: Colors.white);
        fetchCommande(currentPage.value);
        Get.to(OrderView());
      } else {
        // Gérer l'erreur
        print("erreur change ${response.body}");
        Get.snackbar('Erreur',
            'Impossible de mettre à jour le statut ${response.statusCode}',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      // Gérer les erreurs de connexion ou autres exceptions
      Get.snackbar('Erreur', 'Une erreur est survenue : $e',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
