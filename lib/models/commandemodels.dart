/* import 'dart:convert';

import 'commandeModel.dart';
import 'promadel.dart';

// Main Order model
class Order {
  final int id;
  final String? person;
  final String? reference;
  //final String? detail; // Nullable
  final int stars;
  final String? status;
  final int? returned;
  final Seller? seller;
  final Client? client;
  final List<Items> items;
  final Delivery? delivery;
  final Expedition? expedition;
  final AfterExpedition? afterExpedition;
  final OrderStatus? canceled;
  final OrderStatus? received;
  final OrderStatus? validated;
  final OrderStatus? postponed;
  final OrderStatus? dontPickUp;
  final OrderStatus? pending;
  final OrderStatus? inProgress;
  final OrderStatus? confirmed;
  final String createdAt;
  final String updatedAt;
  final String createdAtFr;
  final String updatedAtFr;

  Order({
     required this.id,
    required this.person,
    required this.reference,
    //this.detail,
    required this.stars,
    required this.status,
    required this.returned,
    required this.seller,
    this.client,
    required this.items,
    required this.delivery,
    required this.expedition,
    required this.afterExpedition,
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
    required this.createdAtFr,
    required this.updatedAtFr,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      person: json['person'],
      reference: json['reference'],
      //detail: json['detail'], // Nullable
      stars: json['stars'],
      status: json['status'],
      returned: json['returned'],
      seller: Seller.fromJson(json['seller']),
      client: json['client'] != null ? Client.fromJson(json['canceled']) : null,
      items: List<Items>.from(json['items'].map((item) => Items.fromJson(item))),
      delivery: Delivery.fromJson(json['delivery']),
      expedition: Expedition.fromJson(json['expedition']),
      afterExpedition: AfterExpedition.fromJson(json['after_expedition']),
      canceled: json['canceled'] != null
          ? OrderStatus.fromJson(json['canceled'])
          : null,
      received: json['recieved'] != null
          ? OrderStatus.fromJson(json['recieved'])
          : null,
      validated: json['validated'] != null
          ? OrderStatus.fromJson(json['validated'])
          : null,
      postponed: json['postponed'] != null
          ? OrderStatus.fromJson(json['postponed'])
          : null,
      dontPickUp: json['dont_pick_up'] != null
          ? OrderStatus.fromJson(json['dont_pick_up'])
          : null,
      pending: json['pending'] != null
          ? OrderStatus.fromJson(json['pending'])
          : null,
      inProgress: json['in_progress'] != null
          ? OrderStatus.fromJson(json['in_progress'])
          : null,
      confirmed: json['confirmed'] != null
          ? OrderStatus.fromJson(json['confirmed'])
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
      //'detail': detail,
      'stars': stars,
      'status': status,
      'returned': returned,
      'seller': seller!.toJson(),
      'client': client?.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'delivery': delivery!.toJson(),
      'expedition': expedition!.toJson(),
      'after_expedition': afterExpedition!.toJson(),
      'canceled': canceled?.toJson(),
      'recieved': received?.toJson(),
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

// Seller model
class Seller {
  //final User user;
  final String firstName;
  final String lastName;
  final String job;
  final City city;
  final int? stars;
  final String? recruiter; // Nullable
  final String? ambassador; // Nullable

  Seller({
    // required this.user,
    required this.firstName,
    required this.lastName,
    required this.job,
    required this.city,
    required this.stars,
    this.recruiter,
    this.ambassador,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      // user: User.fromJson(json['user']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      job: json['job'],
      city: City.fromJson(json['city']),
      stars: json['stars'],
      recruiter: json['recruiter'], // Nullable
      ambassador: json['ambassador'], // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'user': user.toJson(),
      'first_name': firstName,
      'last_name': lastName,
      'job': job,
      'city': city.toJson(),
      'stars': stars,
      'recruiter': recruiter,
      'ambassador': ambassador,
    };
  }
}

class City {
  //final int? id; // City ID
  final String? name; // City name
  final Country? country; // Associated country

  City({
    //this.id,
    this.name,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      // id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,
      'name': name,
      'country': country?.toJson(),
    };
  }
}

// User model
/* class User {
  final int id;
  final String email;
  final String phoneNumber;

  User({
    required this.id,
    required this.email,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
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
} */

// Client model
class Client {
  final String? name;
  final String? phoneNumber;
  final String? phoneNumber2; // Nullable

  Client({
    this.name,
    this.phoneNumber,
    this.phoneNumber2,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      name: json['name'],
      phoneNumber: json['phone_number'],
       phoneNumber2: json['phone_number_2'], // Nullable
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'phone_number_2': phoneNumber2,
    };
  }
}

// Items model
class Items {
  final String reference;
  final int? star;
  final int? price;
  final int? quantity;
  final int? fees;
  final String? size; // Nullable
  final String? color; // Nullable
  final Product product;
  final String status;
  final int? percentage;
  final int? orderCommission;
  final int? sellerCommission;
  final int? recruiterCommission;
  final int? focalPointCommission;
  final bool payment;
  final OrderStatus? canceled;
  final OrderStatus? validated;
  final dynamic refund; // Nullable
  final int? totalProduct;
  final int? totalFees;
  final int? total;

  Items({
    required this.reference,
    this.star,
    this.price,
    this.quantity,
    this.fees,
    this.size,
    this.color,
    required this.product,
    required this.status,
    required this.percentage,
    required this.orderCommission,
    required this.sellerCommission,
    required this.recruiterCommission,
    required this.focalPointCommission,
    required this.payment,
    this.canceled,
    this.validated,
    this.refund,
    this.totalProduct,
    this.totalFees,
    this.total,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      reference: json['reference'],
      star: json['star'],
      price: json['price'],
      quantity: json['quantity'],
      fees: json['fees'],
      size: json['size'], // Nullable
      color: json['color'], // Nullable
      product: Product.fromJson(json['product']),
      status: json['status'],
      percentage: json['percentage'],
      orderCommission: json['order_commission'],
      sellerCommission: json['seller_commission'],
      recruiterCommission: json['recruiter_commission'],
      focalPointCommission: json['focal_point_commission'],
      payment: json['payment'],
      canceled: json['canceled'] != null
          ? OrderStatus.fromJson(json['canceled'])
          : null,
      validated: json['validated'] != null
          ? OrderStatus.fromJson(json['validated'])
          : null,
      refund: json['refund'], // Nullable
      totalProduct: json['total_product'],
      totalFees: json['total_fees'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'star': star,
      'price': price,
      'quantity': quantity,
      'fees': fees,
      'size': size,
      'color': color,
      'product': product.toJson(),
      'status': status,
      'percentage': percentage,
      'order_commission': orderCommission,
      'seller_commission': sellerCommission,
      'recruiter_commission': recruiterCommission,
      'focal_point_commission': focalPointCommission,
      'payment': payment,
      'canceled': canceled?.toJson(),
      'validated': validated?.toJson(),
      'refund': refund,
      'total_product': totalProduct,
      'total_fees': totalFees,
      'total': total,
    };
  }
}

class Product {
  final int? id;
  final String? approvedOrDisapprovedDate;
  final String? reasonDisapproved;
  final int? publish;
  final Shop? shop;
  final SubCategory? subCategory;
  final State? state;
  final dynamic brand;
  final int? popular;
  final String? code;
  final String? category;
  final String? name;
  final String? subTitle;
  final String? description;
  final String? alias;
  final int? outStock;
  final int? unavailable;
  final int? invisible;
  final int? stock;
  final int? views;
  final dynamic link;
  final Price? price;
  final PriceDelivery? priceDelivery;
  final List<String>? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.approvedOrDisapprovedDate,
    this.reasonDisapproved,
    this.publish,
    this.shop,
    this.subCategory,
    this.state,
    this.brand,
    this.popular,
    this.code,
    this.category,
    this.name,
    this.subTitle,
    this.description,
    this.alias,
    this.outStock,
    this.unavailable,
    this.invisible,
    this.stock,
    this.views,
    this.link,
    this.price,
    this.priceDelivery,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      approvedOrDisapprovedDate: json['approved_or_disapproved_date'],
      reasonDisapproved: json['reason_disapproved'],
      publish: json['publish'],
      shop: json['shop'] != null ? Shop.fromJson(json['shop']) : null,
      subCategory: json['sub_category'] != null
          ? SubCategory.fromJson(json['sub_category'])
          : null,
      state: json['state'] != null ? State.fromJson(json['state']) : null,
      brand: json['brand'],
      popular: json['popular'],
      code: json['code'],
      category: json['category'],
      name: json['name'],
      subTitle: json['sub_title'],
      description: json['description'],
      alias: json['alias'],
      outStock: json['out_stock'],
      unavailable: json['unavailable'],
      invisible: json['invisible'],
      stock: json['stock'],
      views: json['views'],
      link: json['link'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      priceDelivery: json['price_delivery'] != null
          ? PriceDelivery.fromJson(json['price_delivery'])
          : null,
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      createdAt: DateTime.tryParse(json['created_at']),
      updatedAt: DateTime.tryParse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'approved_or_disapproved_date': approvedOrDisapprovedDate,
      'reason_disapproved': reasonDisapproved,
      'publish': publish,
      'shop': shop?.toJson(),
      'sub_category': subCategory?.toJson(),
      'state': state?.toJson(),
      'brand': brand,
      'popular': popular,
      'code': code,
      'category': category,
      'name': name,
      'sub_title': subTitle,
      'description': description,
      'alias': alias,
      'out_stock': outStock,
      'unavailable': unavailable,
      'invisible': invisible,
      'stock': stock,
      'views': views,
      'link': link,
      'price': price?.toJson(),
      'price_delivery': priceDelivery?.toJson(),
      'images': images,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class PriceDelivery {
  final int? city; // Nullable field
  final int? noCity; // Nullable field

  PriceDelivery({
    this.city,
    this.noCity,
  });

  factory PriceDelivery.fromJson(Map<String, dynamic> json) {
    return PriceDelivery(
      city: json['city'],
      noCity: json['no_city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'no_city': noCity,
    };
  }
}

class Price {
  final int? price;
  final int? partner;
  final int? supplier;
  final int? seller;
  final int? max;
  final int? min;
  final int? commission; // This can be null

  Price({
    this.price,
    this.partner,
    this.supplier,
    this.seller,
    this.max,
    this.min,
    this.commission,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      price: json['price'],
      partner: json['partner'],
      supplier: json['supplier'],
      seller: json['seller'],
      max: json['max'],
      min: json['min'],
      commission: json['commission'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'partner': partner,
      'supplier': supplier,
      'seller': seller,
      'max': max,
      'min': min,
      'commission': commission,
    };
  }
}

// Delivery model
class Delivery {
  final String? date;
  final String? time;
  final City? city;

  Delivery({
    this.date,
    this.time,
    this.city,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) {
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

// Expedition model
class Expedition {
  final String? actor;
  //final dynamic user; // Assuming user can be null or have a complex type
  final ExpeditionData? data;

  Expedition({
    this.actor,
    //this.user,
    this.data,
  });

  factory Expedition.fromJson(Map<String, dynamic> json) {
    return Expedition(
      actor: json['actor'],
      // user: json['user'], // Adjust this if user has a specific structure
      data: json['data'] != null ? ExpeditionData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'actor': actor,
      // 'user': user,
      'data': data?.toJson(),
    };
  }
}

class ExpeditionData {
  final String? code;
  final String? name;
  final City? city;

  ExpeditionData({
    this.code,
    this.name,
    this.city,
  });

  factory ExpeditionData.fromJson(Map<String, dynamic> json) {
    return ExpeditionData(
      code: json['code'],
      name: json['name'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'city': city?.toJson(),
    };
  }
}

// AfterExpedition model
class AfterExpedition {
  final String? date;
  final String? status;

  AfterExpedition({
    this.date,
    this.status,
  });

  factory AfterExpedition.fromJson(Map<String, dynamic> json) {
    return AfterExpedition(
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'status': status,
    };
  }
}

class OrderStatus {
  final String? reason; // Nullable reason for the status
  final String? date; // Nullable date
  final String? time; // Nullable time

  OrderStatus({
    this.reason,
    this.date,
    this.time,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
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
 */