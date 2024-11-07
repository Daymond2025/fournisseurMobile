import 'commandemodels.dart';
import 'order_table.dart';

class TransactionModel {
  int id;
  String? reference;
  String? transactionId;
  int? amount;
  String? category;
  String? status;
  String? operator;
  String? phoneNumber;
  Order? commande;
/*   BusinessData? from;
  BusinessData? destination; */
  //String? note;
  String createdAt;
  String updatedAt;
  String createdAtFr;
  String updatedAtFr;

  TransactionModel({
    required this.id,
    this.reference,
    this.transactionId,
    this.amount,
    this.category,
    this.status,
    this.operator,
    this.phoneNumber,
    this.commande,
/*     this.from,
    this.destination, */
    //this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      reference: json['reference'],
      transactionId: json['transaction_id'],
      amount: json['amount'],
      category: json['category'],
      status: json['status'],
      operator: json['operator'],
      phoneNumber: json['phone_number'],
      commande: json['order'] != null ? Order.fromJson(json['order']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }
}

class BusinessData {
  int id;
  String logo;
  String name;
  String ncc;
  String email;
  String phoneNumber;
  String address;
  List<String> registersPath;

  BusinessData({
    required this.id,
    required this.logo,
    required this.name,
    required this.ncc,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.registersPath,
  });

  factory BusinessData.fromJson(Map<String, dynamic> json) {
    return BusinessData(
      id: json['id'],
      logo: json['logo'],
      name: json['name'],
      ncc: json['ncc'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      registersPath: List<String>.from(json['registers_path']),
    );
  }
}
