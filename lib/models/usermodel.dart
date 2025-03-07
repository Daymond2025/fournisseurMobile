import 'package:daymond_dis/models/shopmodel.dart';

class User {
  final int id;
  final String? picture;
  final String email;
  final String? phoneNumber;
  final String createdAt;
  final String updatedAt;
  final String createdAtFr;
  final String updatedAtFr;
  final Entity entity;

  //final Option option;

  User({
    required this.id,
    this.picture,
    required this.email,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
    required this.entity,
    //required this.option,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      picture: json['picture'],
      email: json['email'],

      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
      entity: Entity.fromJson(json['entity']),
      // option: Option.fromJson(json['option']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'name': nom,
      'id': id,
      'entity': entity,
    };
  }
}

class Entity {
  final String? firstName;
  final String? lastName;
  final Shops shop;
  final List? categories;
  final int id;

  Entity(
      {required this.firstName,
      required this.lastName,
      required this.shop,
      required this.id,
      this.categories});

  factory Entity.fromJson(Map<String, dynamic> json) {
    // print("leshop ${json['shop']}");
    return Entity(
      firstName: json['first_name'],
      lastName: json['last_name'],
      categories: json['categories_product'] as List ?? [],
      shop: Shops.fromJson(json['shop']),
      id: json['id'],
    );
  }
}

class Option {
  final String? role;
  final int isAdmin;

  Option({this.role, required this.isAdmin});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      role: json['role'],
      isAdmin: json['is_admin'],
    );
  }
}

class Projet {
  //String nom;
  String marque;
  String description;
  int etat;
  int quantite;
  double? price_city_delivery;
  double? price_no_city_delivery;
  double prixOfficiel;
  double prixPartenaire;
  List<String> tailles;
  List<Map<String, dynamic>> couleurs;
  String codeProduit;
  List<String> imagePaths;

  Projet({
    // required this.nom,
    this.price_city_delivery,
    this.price_no_city_delivery,
    required this.marque,
    required this.description,
    required this.etat,
    required this.quantite,
    required this.prixOfficiel,
    required this.prixPartenaire,
    required this.tailles,
    required this.couleurs,
    required this.codeProduit,
    required this.imagePaths,
  });

  Map<String, dynamic> toJson() {
    return {
      // 'name': nom,
      'name': marque,
      'description': description,
      'state_id': etat,
      'quantity': quantite,
      'price_supplier': prixOfficiel,
      'price_partner': prixPartenaire,
      'price_city_delivery': price_city_delivery,
      'price_no_city_delivery': price_no_city_delivery,
      'sizes': tailles,
      'colors': couleurs,
      'code_produit': codeProduit,
      'images': imagePaths,
    };
  }
}
