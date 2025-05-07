import 'dart:io';

import 'package:daymond_dis/screens/auth/loginScreen.dart';
import 'package:daymond_dis/screens/newScreens/connexion/connexion_widget.dart';
import 'package:daymond_dis/screens/views/produits/produitscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants/constantApp.dart';
import '../models/walletmodel.dart';
import '../models/produitsmodels.dart';
import '../models/promadel.dart';
import '../models/usermodel.dart'; // Import your Product model

class ProductController extends GetxController {
  // List to store products
  var stoks = ''.obs;

  //Rx<List<TransactionOrder>> transactionOrder = Rx<List<TransactionOrder>>([]);
  final formKey = GlobalKey<FormState>();
  Rx<List<Product>> productList = Rx<List<Product>>([]);
  var isLoading = true.obs;

  var isLoadingproduit = false.obs;

  // Fetch products from API
  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);

      // Get token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return;
      }

      // Make the API request with token in headers
      final response = await http.get(
        Uri.parse(AppConstants.fetchproduit),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print('produitdaymond @#####${response.body}');

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body)['data'];
        print('object$jsonData');
        if (jsonData != null) {
          // Continue avec le mapping si jsonData n'est pas null
          for (var item in jsonData) {
            productList.value.add(Product.fromJson(item));
          }
        } else {
          Get.snackbar("Error", "No data found in response");
        }
      } else if (response.statusCode == 401) {
        Get.snackbar("Error", "Unauthorized access, please log in again.");
      } else {
        Get.snackbar(
            "Error", "Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> submitProjets(Projet projet) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(AppConstants.fetchproduit),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Optional if you have authentication
        },
        body: json.encode(projet.toJson()),
      );

      if (response.statusCode == 200) {
        // Success, handle accordingly
        return true;
      } else {
        // Failed, handle errors
        print('Error: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      return false;
    }
  }
}

class ProducttController extends GetxController {
  var stoks = ''.obs;

  //Rx<List<TransactionOrder>> transactionOrder = Rx<List<TransactionOrder>>([]);
  final formKey = GlobalKey<FormState>();
  //Rx<List<Product>> productList = Rx<List<Product>>([]);
  // var isLoading = true.obs;

  var isLoadingproduit = false.obs;
  var productList = <Product>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var lastPage = 1.obs;

  final int itemsPerPage = 20;

  @override
  void onInit() {
    super.onInit();
    fetchProducts(currentPage.value);
  }

  Future<bool> submitProjet(Projet projet, {int? idshop}) async {
    isLoadingproduit(true);

    try {
      EasyLoading.show(status: "Un instant...");
      var uri = Uri.parse(
          AppConstants.fetchproduit); // Remplace avec l'URL de ton API
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var request = http.MultipartRequest('POST', uri);

      // Ajouter le token dans les en-têtes
      if (token != null) {
        request.headers['Authorization'] =
            'Bearer $token'; // Ajouter le token au format Bearer
      }

      // Ajouter d'autres champs au formulaire
      request.fields['shop_id'] = idshop.toString();
      request.fields['name'] = projet.marque;
      request.fields['description'] = projet.description;
      request.fields['state_id'] = projet.etat.toString();
      request.fields['quantity'] = projet.quantite.toString();
      request.fields['price_supplier'] = projet.prixOfficiel.toString();
      request.fields['price_partner'] = projet.prixPartenaire.toString();
      request.fields['price_city_delivery'] =
          projet.price_city_delivery.toString();
      request.fields['price_no_city_delivery'] =
          projet.price_no_city_delivery.toString();
      request.fields['codeProduit'] = projet.codeProduit;

      // Ajouter les tailles
      for (int i = 0; i < projet.tailles.length; i++) {
        request.fields['sizes[$i]'] = projet.tailles[i];
      }

      // Ajouter les couleurs
      for (int i = 0; i < projet.couleurs.length; i++) {
        projet.couleurs[i].remove('color'); // Supprime la clé 'color'
        request.fields['colors[$i]'] = jsonEncode(projet.couleurs[i]);
        // request.fields['colors[$i]'] = projet.couleurs[i]['name'];
      }

      // Ajouter les fichiers d'image
      for (int i = 0; i < projet.imagePaths.length; i++) {
        if (projet.imagePaths[i].isNotEmpty) {
          File imageFile = File(projet.imagePaths[i]);

          // Vérifier si le fichier existe avant de l'ajouter
          if (await imageFile.exists()) {
            request.files.add(
              await http.MultipartFile.fromPath(
                  'images[$i]', projet.imagePaths[i]),
            );
          }
        }
      }

      // Envoyer la requête
      var response = await request.send();
      var responseData = await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 201) {
        print('object $responseData');
        fetchProducts(currentPage.value);
        Get.to(() => ProduitScreen());
        return true; // Succès
      } else {
        // Affiche la réponse pour obtenir des détails supplémentaires
        print('Erreur: $responseData ${response.statusCode}');
        return false; // Échec
      }
    } finally {
      isLoadingproduit(false);
      EasyLoading.dismiss();
    }
  }

  Future<void> fetchProducts(int page) async {
    isLoading(true);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var url = '${AppConstants.fetchproduit}?page=$page';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print("fetch reponse : ${response.statusCode}");
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        List<Product> fetchedProducts = (data['data'] as List)
            .map((productData) => Product.fromJson(productData))
            .toList();

        productList.assignAll(fetchedProducts);
        currentPage.value = data['meta']['current_page'];
        lastPage.value = data['meta']['last_page'];
      } else {
        // Get.offAll(ConnexionWidget());
        Get.snackbar("Error", "Failed to load products");
      }
    } catch (e) {
      // Get.offAll(ConnexionWidget());
      Get.snackbar("Error", "An error occurred while fetching products");
    } finally {
      isLoading(false);
    }
  }

  Future<void> stoksUpdate(int? id, String stoks, String params) async {
    // Changez Createpayement en createPayment
    EasyLoading.show(status: "Un instant...");
    // Assuming you have a URL for your API endpoint
    String apiUrl = AppConstants.updateproduit;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "Token not found");
      return;
    }
    print('$params');
    print('object$stoks');
    // Envoyer la requête POST
    final response = await http.post(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
        //'Content-Type': 'application/json', // Spécifiez le type de contenu
      },
      body: {
        'option': params,
        'stock': stoks,
      },
    );

    if (response.statusCode == 201) {
      EasyLoading.showSuccess('Modification valider');
      print('Errorpays: ${response.statusCode}, ${response.body}');
      fetchProducts(currentPage.value);
      Get.off(ProduitScreen());
    } else {
      //EasyLoading.showError('Failed to submit. Please try again.');
      // API call failed
      EasyLoading.showError('Echèc');
      EasyLoading.dismiss();
      // Handle error, show a message, etc.
      print('Errorpays: ${response.statusCode}, ${response.body}');
      // Optionally, you can show an error message using EasyLoading.showError()
    }
    EasyLoading.dismiss();
  }

  Future<void> stoksoutUpdate(
    int? id,
  ) async {
    // Changez Createpayement en createPayment
    EasyLoading.show(status: "Un instant...");
    // Assuming you have a URL for your API endpoint
    String apiUrl = AppConstants.updatestockproduit;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      Get.snackbar("Error", "Token not found");
      return;
    }

    // Envoyer la requête POST
    final response = await http.post(
      Uri.parse('$apiUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
        // 'Content-Type': 'application/json', // Spécifiez le type de contenu
      },
      body: {
        'option': 'out_stock',
      },
    );

    if (response.statusCode == 201) {
      EasyLoading.showSuccess('Modification valider');
      print('Errorpays: ${response.statusCode}, ${response.body}');
      fetchProducts(currentPage.value);
      Get.off(ProduitScreen());
    } else {
      //EasyLoading.showError('Failed to submit. Please try again.');
      // API call failed
      EasyLoading.showError('Echèc');
      EasyLoading.dismiss();
      // Handle error, show a message, etc.
      print('Errorpays: ${response.statusCode}, ${response.body}');
      // Optionally, you can show an error message using EasyLoading.showError()
    }
    EasyLoading.dismiss();
  }

  void goToPage(int page) {
    if (page > 0 && page <= lastPage.value) {
      fetchProducts(page);
    }
  }

  Future<bool> updateProjet(Projet projet, int? id) async {
    isLoadingproduit(true);

    try {
      EasyLoading.show(status: "Un instant...");
      var uri = Uri.parse(
          '${AppConstants.fetchproduit}/$id'); // Remplace avec l'URL de ton API, incluant l'ID du projet
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      var request = http.MultipartRequest('POST', uri); // Change 'POST' à 'PUT'

      // Ajouter le token dans les en-têtes
      if (token != null) {
        request.headers['Authorization'] =
            'Bearer $token'; // Ajouter le token au format Bearer
      }

      // Ajouter d'autres champs au formulaire
      request.fields['option'] = 'product';
      request.fields['name'] = projet.marque;
      request.fields['description'] = projet.description;
      request.fields['state_id'] = projet.etat.toString();
      request.fields['quantity'] = projet.quantite.toString();
      request.fields['price_supplier'] = projet.prixOfficiel.toString();
      request.fields['price_partner'] = projet.prixPartenaire.toString();
      request.fields['codeProduit'] = projet.codeProduit;

      // Ajouter les tailles
      for (int i = 0; i < projet.tailles.length; i++) {
        request.fields['sizes[$i]'] = projet.tailles[i];
      }

      // Ajouter les couleurs
      for (int i = 0; i < projet.couleurs.length; i++) {
        request.fields['colors[$i][name]'] = projet.couleurs[i]['name'];
        request.fields['colors[$i][colors]'] =
            projet.couleurs[i]['colors'].toString();
      }

      // Ajouter les fichiers d'image
      for (int i = 0; i < projet.imagePaths.length; i++) {
        if (projet.imagePaths[i].isNotEmpty) {
          File imageFile = File(projet.imagePaths[i]);

          // Vérifier si le fichier existe avant de l'ajouter
          if (await imageFile.exists()) {
            request.files.add(
              await http.MultipartFile.fromPath(
                  'images[$i]', projet.imagePaths[i]),
            );
          }
        }
      }

      // Envoyer la requête
      var response = await request.send();
      var responseData = await response.stream.transform(utf8.decoder).join();

      if (response.statusCode == 201) {
        // Changer 201 à 200 pour une réponse de succès standard
        print('object $responseData');
        fetchProducts(currentPage.value);
        Get.off(ProduitScreen());
        return true; // Succès
      } else {
        // Affiche la réponse pour obtenir des détails supplémentaires
        print('Erreur: $responseData ${response.statusCode}');
        return false; // Échec
      }
    } finally {
      isLoadingproduit(false);
      EasyLoading.dismiss();
    }
  }
}
