//Commande
import 'promadel.dart';

class Order {
  final int id;
  final String person;
  final String reference;
  final String? detail;
  final int stars;
  final String status;
  final bool returned;
  final Seller seller;
  final Client? client;
  final List<OrderItem> items;
  final Delivery? delivery;
  final Expedition? expedition;
  final Expedition? afterExpedition;
  final OrderStatusDetail? canceled;
  final OrderStatusDetail? received;
  final OrderStatusDetail? validated;
  final OrderStatusDetail? postponed;
  final OrderStatusDetail? dontPickUp;
  final OrderStatusDetail? pending;
  final OrderStatusDetail? inProgress;
  final OrderStatusDetail? confirmed;
  final String createdAt;
  final String updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;
  final int? commissionApplied;

  Order(
      {required this.id,
      required this.person,
      required this.reference,
      this.detail,
      required this.stars,
      required this.status,
      required this.returned,
      required this.seller,
      this.client,
      required this.items,
      this.delivery,
      this.expedition,
      this.afterExpedition,
      this.canceled,
      this.received,
      this.validated,
      this.postponed,
      this.dontPickUp,
      this.pending,
      this.inProgress,
      this.confirmed,
      required this.createdAt,
      required this.updatedAt,
      this.createdAtFr,
      this.updatedAtFr,
      this.commissionApplied});

  factory Order.fromJson(Map<String, dynamic> json) {
    print('Commande $json');
    return Order(
      id: json['id'],
      person: json['person'],
      reference: json['reference'],
      detail: json['detail'],
      stars: json['stars'],
      status: json['status'],
      commissionApplied: json['commission_applied'],
      returned: json['returned'] == 1,
      seller: Seller.fromJson(json['seller']),
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      delivery:
          json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
      expedition: json['expedition'] != null
          ? Expedition.fromJson(json['expedition'])
          : null,
      afterExpedition: json['after_expedition'] != null
          ? Expedition.fromJson(json['after_expedition'])
          : null,
      canceled: json['canceled'] != null
          ? OrderStatusDetail.fromJson(json['canceled'])
          : null,
      received: json['received'] != null
          ? OrderStatusDetail.fromJson(json['received'])
          : null,
      validated: json['validated'] != null
          ? OrderStatusDetail.fromJson(json['validated'])
          : null,
      postponed: json['postponed'] != null
          ? OrderStatusDetail.fromJson(json['postponed'])
          : null,
      dontPickUp: json['dont_pick_up'] != null
          ? OrderStatusDetail.fromJson(json['dont_pick_up'])
          : null,
      pending: json['pending'] != null
          ? OrderStatusDetail.fromJson(json['pending'])
          : null,
      inProgress: json['in_progress'] != null
          ? OrderStatusDetail.fromJson(json['in_progress'])
          : null,
      confirmed: json['confirmed'] != null
          ? OrderStatusDetail.fromJson(json['confirmed'])
          : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'person': person,
      'reference': reference,
      'detail': detail,
      'stars': stars,
      'status': status,
      'returned': returned ? 1 : 0,
      'seller': seller.toJson(),
      'client': client?.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'delivery': delivery?.toJson(),
      'expedition': expedition?.toJson(),
      'after_expedition': afterExpedition?.toJson(),
      'canceled': canceled?.toJson(),
      'received': received?.toJson(),
      'validated': validated?.toJson(),
      'postponed': postponed?.toJson(),
      'dont_pick_up': dontPickUp?.toJson(),
      'pending': pending?.toJson(),
      'in_progress': inProgress?.toJson(),
      'confirmed': confirmed?.toJson(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}

//Users
class Users {
  final int id;
  final String? email;
  final String phoneNumber;

  Users({
    required this.id,
    this.email,
    required this.phoneNumber,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    print('Users $json');
    return Users(
      id: json['id'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone_number': phoneNumber,
    };
  }
}

//ville
class City {
  final int id;
  final String? name;
  Country? country;

  City({
    required this.id,
    this.name,
    this.country,
  });

  // Méthode pour convertir un Map JSON en instance de City
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }

  // Méthode pour convertir une instance de City en Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // 'country': country!.toJson(),
    };
  }
}

class Country {
  final int id;
  final String flag;
  final String code;
  final String currency;
  final String name;
  final String nationality;
  final List<City> cities;

  Country({
    required this.id,
    required this.flag,
    required this.code,
    required this.currency,
    required this.name,
    required this.nationality,
    required this.cities,
  });

  // Méthode pour convertir un Map JSON en instance de Country
  factory Country.fromJson(Map<String, dynamic> json) {
    var citiesFromJson = json['cities'] as List;
    List<City> cityList =
        citiesFromJson.map((cityJson) => City.fromJson(cityJson)).toList();

    return Country(
      id: json['id'],
      flag: json['flag'] ?? '',
      code: json['code'],
      currency: json['currency'],
      name: json['name'],
      nationality: json['nationality'],
      cities: cityList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'flag': flag,
      'code': code,
      'currency': currency,
      'name': name,
      'nationality': nationality,
      'cities': cities.map((city) => city.toJson()).toList(),
    };
  }
}

//Vendeur
class Seller {
  final int id;
  final Users user;
  final String firstName;
  final String lastName;
  final String job;
  final String city;
  final int stars;

  Seller({
    required this.id,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.job,
    required this.city,
    required this.stars,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    print('Vendeur $json');
    return Seller(
      id: json['id'],
      user: Users.fromJson(json['user']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      job: json['job'],
      city: json['city'],
      stars: json['stars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'first_name': firstName,
      'last_name': lastName,
      'job': job,
      'city': city,
      'stars': stars,
    };
  }
}

//Client
class Client {
  final String? name;
  final String? phoneNumber;
  final String? phoneNumber2;

  Client({
    this.name,
    this.phoneNumber,
    this.phoneNumber2,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      phoneNumber: json['phone_number'],
      phoneNumber2: json['phone_number_2'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'phone_number2': phoneNumber2,
    };
  }
}

// Item de produit
class OrderItem {
  final String reference;
  final int star;
  final int price;
  final int quantity;
  final int fees;
  final int totalproduct;
  final int totalfees;
  final int total;
  final Product product;

  OrderItem({
    required this.reference,
    required this.star,
    required this.price,
    required this.quantity,
    required this.fees,
    required this.total,
    required this.totalfees,
    required this.totalproduct,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    print('Item de produit $json');
    return OrderItem(
      reference: json['reference'],
      star: json['star'],
      price: json['price'],
      quantity: json['quantity'],
      fees: json['fees'],
      total: json['total'],
      totalfees: json['total_fees'],
      totalproduct: json['total_product'],
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'star': star,
      'price': price,
      'quantity': quantity,
      'fees': fees,
      'total': total,
      'total_fees': totalfees,
      'total_product': totalproduct,
      'product': product.toJson(),
    };
  }
}

//Livraison
class Delivery {
  final String date;
  final String time;
  City? city;

  Delivery({
    required this.date,
    required this.time,
    required this.city,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
    print('Livraison $json');
    return Delivery(
      date: json['date'],
      time: json['time'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'city': city?.toJson(),
    };
  }
}

//Expedition
class Expedition {
  final String actor;
  final Users? user;
  final dynamic data;

  Expedition({
    required this.actor,
    this.user,
    this.data,
  });

  factory Expedition.fromJson(Map<String, dynamic> json) {
    print('Expedition $json');
    return Expedition(
      actor: json['actor'],
      user: json['user'] != null ? Users.fromJson(json['user']) : null,
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actor': actor,
      'user': user?.toJson(),
      'data': data,
    };
  }
}

//Status de commande
class OrderStatusDetail {
  final String? reason;
  final String? date;
  final String? time;

  OrderStatusDetail({
    this.reason,
    this.date,
    this.time,
  });

  factory OrderStatusDetail.fromJson(Map<String, dynamic> json) {
    print('object$json');
    return OrderStatusDetail(
      reason: json['reason'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'date': date,
      'time': time,
    };
  }
}
