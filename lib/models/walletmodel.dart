class Wallet {
  final int? amount;
  final int? totalAmount;
  final String? person;
  final int? personId;
  final Entity? entity;

  Wallet({
    this.amount,
    this.totalAmount,
    this.person,
    this.personId,
    this.entity,
  });

  // Le constructeur fromJson
  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      amount: json['amount'] ?? 0, // Remplace null par 0
      totalAmount: json['total_amount'] != null
          ? json['total_amount']
          : 0, // Remplace null par 0
      person: json['person'],
      personId: json['person_id'],
      entity: json['entity'] != null ? Entity.fromJson(json['entity']) : null,
    );
  }

  // Méthode toJson pour la sérialisation
  Map<String, dynamic> toJson() {
    return {
      'amount':
          amount, // Pas besoin de vérifier ici, amount est déjà non-nullable
      'total_amount': totalAmount, // Même chose ici
      'person': person,
      'person_id': personId,
      'entity': entity?.toJson(),
    };
  }
}

class Entity {
  final String? logo;
  final String? name;
  final String? ncc;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final List<String>? registersPath;
  final String? createdAt;
  final String? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Entity({
    this.logo,
    this.name,
    this.ncc,
    this.email,
    this.phoneNumber,
    this.address,
    this.registersPath,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      logo: json['logo'],
      name: json['name'],
      ncc: json['ncc'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      registersPath: List<String>.from(json['registers_path']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logo': logo,
      'name': name,
      'ncc': ncc,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'registers_path': registersPath,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}

class FinancialData {
  final int chiffreAffaire;
  final int solde;
  final int aSolder;
  final int retraitJour;
  final int rechargeJour;
  final int commissionJour;
  final int nbNouvelleCommande;
  final int nbCommandeValidee;

  FinancialData({
    required this.chiffreAffaire,
    required this.solde,
    required this.aSolder,
    required this.retraitJour,
    required this.rechargeJour,
    required this.commissionJour,
    required this.nbNouvelleCommande,
    required this.nbCommandeValidee,
  });

  // Méthode pour convertir du JSON vers un objet FinancialData
  factory FinancialData.fromJson(Map<String, dynamic> json) {
    return FinancialData(
      chiffreAffaire: json['chiffre_affaire'],
      solde: json['solde'],
      aSolder: json['a_solder'],
      retraitJour: json['retrait_jour'],
      rechargeJour: json['recharge_jour'],
      commissionJour: json['commission_jour'],
      nbNouvelleCommande: json['nb_nouvelle_commande'],
      nbCommandeValidee: json['nb_commande_validee'],
    );
  }

  // Méthode pour convertir un objet FinancialData vers JSON
  Map<String, dynamic> toJson() {
    return {
      'chiffre_affaire': chiffreAffaire,
      'solde': solde,
      'a_solder': aSolder,
      'retrait_jour': retraitJour,
      'recharge_jour': rechargeJour,
      'commission_jour': commissionJour,
      'nb_nouvelle_commande': nbNouvelleCommande,
      'nb_commande_validee': nbCommandeValidee,
    };
  }
}

