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
}

class Entity {
  final String? firstName;
  final String? lastName;

  Entity({required this.firstName, required this.lastName});

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class Option {
  final String? role;
  final int isAdmin;

  Option({this.role,required this.isAdmin});

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
  double prixOfficiel;
  double prixPartenaire;
  List<String> tailles;
  List<Map<String, dynamic>> couleurs;
  String codeProduit;
  List<String> imagePaths;

  Projet({
    // required this.nom,

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
      'sizes': tailles,
      'colors': couleurs,
      'code_produit': codeProduit,
      'images': imagePaths,
    };
  }
}
