import 'dart:convert';
import 'dart:io';
import 'package:daymond_dis/models/categorieModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_pages.dart';
import '../constants/constantApp.dart';
import '../models/usermodel.dart';
import 'GetUsercontroller.dart';

class Suppliercontroller extends GetxController {
  Future<bool> envoiCodeForRegister(String data) async {
    try {
      final response = await http.post(
        Uri.parse("https://v2.daymondboutique.com/api/v2/suppliercode"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"email": data}),
      );

      if (response.statusCode == 200) {
        // Success, handle accordingly
        print("SUCCESS");
        EasyLoading.dismiss();
        return true;
      } else {
        // Failed, handle errors
        print('Error: ${response.body}');
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> updateFournisseur({
    required int id,
    required String firstName,
    String? lastName,
    required String email,
    required String phoneNumber,
  }) async {
    print("id: $id");
    try {
      String apiUrl = AppConstants.updateUser;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return false;
      }

      // Envoyer la requête POST
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
          // 'Content-Type': 'application/json', // Spécifiez le type de contenu
        },
        body: {
          'phone_number': phoneNumber,
          'email': email,
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convertir la réponse en JSON
        EasyLoading.dismiss();
        var responseData = jsonDecode(response.body);

        return true;
      } else {
        EasyLoading.dismiss();
        print('Erreur API: ${response.body}');
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Exception: $e');
      return false;
    }
  }

  Future<bool> updateShop({
    int? id,
    required int cityId,
    required int supplierId,
    required String shopName,
    required String? address,
    List<CatParams>? categoriesProduct, // Liste de JSON
    required String phoneNumber,
  }) async {
    print("id: $id");
    try {
      String apiUrl = AppConstants.updateShop;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        Get.snackbar("Error", "Token not found");
        return false;
      }

      // Envoyer la requête POST
      final response = await http.put(
        Uri.parse('$apiUrl/$id'),
        headers: {
          'Authorization': 'Bearer $token', // Ajout du token dans les en-têtes
          // 'Content-Type': 'application/json', // Spécifiez le type de contenu
        },
        body: {
          'phone_number': phoneNumber,
          'city_id': cityId.toString(),
          'supplier_id': supplierId.toString(),
          'shop_name': shopName,
          'categories_product':
              categoriesProduct != null ? jsonEncode(categoriesProduct) : null,
          'address': address
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convertir la réponse en JSON
        var responseData = jsonDecode(response.body);
        EasyLoading.dismiss();

        return true;
      } else {
        print('Erreur API: ${response.body}');
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      print('Exception: $e');
      EasyLoading.dismiss();
      return false;
    }
  }

  Future<bool> inscription({
    required int cityId,
    int? businessId,
    required String name,
    required String code,
    required String address,
    required String email,
    required String phoneNumberShop,
    required String phoneNumber,
    required String firstName,
    String? lastName,
    List<File?>? shopPictures, // Liste d'images
    List<CatParams>? categoriesProduct, // Liste de JSON
    File? picturePath, // Image unique
  }) async {
    try {
      // URL de l'API
      Uri uri =
          Uri.parse("https://v2.daymondboutique.com/api/v2/supplierregister");

      // Création de la requête multipart
      var request = http.MultipartRequest("POST", uri);

      var cpt = 0;
      var cpt2 = 0;

      // Ajout des champs standards
      request.fields['city_id'] = cityId.toString();
      if (businessId != null)
        request.fields['business_id'] = businessId.toString();
      request.fields['name'] = name;
      request.fields['code'] = code;
      request.fields['address'] = address;
      request.fields['email'] = email;
      request.fields['phone_number_shop'] = phoneNumberShop;
      request.fields['phone_number'] = phoneNumber;
      request.fields['operator_withdrawal'] = getOperateur(phoneNumber);
      request.fields['first_name'] = firstName;
      if (lastName != null) request.fields['last_name'] = lastName;

      // Ajout de la liste de JSON (categories_product)
      if (categoriesProduct != null) {
        List<Map<String, dynamic>> categoriesProductJson = [];

        for (var cat in categoriesProduct) {
          categoriesProductJson
              .add(cat.toJson()); // Ajouter chaque objet au tableau
          request.fields['categories_product[$cpt2]'] =
              jsonEncode(cat.toJson()); // Convertir chaque catégorie en JSON
          cpt2++;
        }
        // request.
        // request.fields['categories_product'] =
        //     jsonEncode(categoriesProductJson);
      }

      // Ajout de la liste d'images (shop_picture)
      if (shopPictures != null) {
        for (var file in shopPictures) {
          request.files.add(await http.MultipartFile.fromPath(
            'shop_picture[$cpt]', // Laravel attend un tableau
            file!.path,
            // filename: "storeimg$cpt",
          ));
          cpt++;
        }
      }

      // Ajout de l'image unique (picture_path)
      if (picturePath != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'picture_path',
          picturePath.path,
          // filename: "logo",
        ));
      }

      // Envoi de la requête
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Convertir la réponse en JSON
        var responseData = jsonDecode(response.body);
        EasyLoading.dismiss();
        return true;
      } else {
        EasyLoading.dismiss();
        print('Erreur API: ${response.body}');
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('Exception: $e');
      return false;
    }
  }
}

String getOperateur(String numero) {
  if (!numero.startsWith("+225") || numero.length < 6) {
    return "Numéro invalide";
  }

  // Extraire les deux premiers chiffres après +225
  String prefixe = numero.substring(4, 6);

  // Déterminer l'opérateur avec switch-case
  switch (prefixe) {
    case "01":
      return "moov";
    case "07":
      return "orange";
    case "05":
      return "mtn";
    default:
      return "Opérateur inconnu";
  }
}
