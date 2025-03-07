import 'dart:convert';

class Shops {
  int? id;
  String? code;
  String? name;
  String? phoneNumber;
  City? city;
  Business? business;
  String? address;
  List? shopPicture;

  Shops(
      {this.id,
      this.code,
      this.name,
      this.city,
      this.business,
      this.phoneNumber,
      this.address,
      this.shopPicture});

  factory Shops.fromJson(Map<String, dynamic> json) {
    return Shops(
      id: json['id'],
      phoneNumber: json['phone_number'] != null ? json['phone_number'] : null,
      code: json['code'],
      shopPicture: json['shop_picture'] != null
          ? (json['shop_picture'] is List
              ? json['shop_picture'] as List
              : jsonDecode(json['shop_picture']))
          : null,
      name: json['name'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      business:
          json['business'] != null ? Business.fromJson(json['business']) : null,
      address: json['address'],
    );
  }
}

class City {
  int? id;
  String? name;
  Country? country;

  City({this.id, this.name, this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }
}

class Country {
  String? flag;
  String? code;
  String? currency;
  String? name;

  Country({this.flag, this.code, this.currency, this.name});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flag: json['flag'],
      code: json['code'],
      currency: json['currency'],
      name: json['name'],
    );
  }
}

class Business {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  String? logo;

  Business({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.logo,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      logo: json['logo'],
    );
  }
}
