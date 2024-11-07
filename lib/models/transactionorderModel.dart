/* import 'commandemodels.dart';
import 'order_table.dart';
import 'promadel.dart';

class TransactionOrder {
  final int id;
  final String reference;
  final String? transactionId;
  final int amount;
  final String category;
  final String status;
  final TransactionOrderDetail? commande;
  final Delivery? delivery;

  TransactionOrder({
    required this.id,
    required this.reference,
    this.transactionId,
    required this.amount,
    required this.category,
    required this.status,
    required this.delivery,
    this.commande,
  });

  factory TransactionOrder.fromJson(Map<String, dynamic> json) {
    return TransactionOrder(
      id: json['id'],
      reference: json['reference'],
      delivery: Delivery.fromJson(json['delivery']),
      transactionId: json['transaction_id'],
      amount: json['amount'],
      category: json['category'],
      status: json['status'],
      commande: json['order'] != null
          ? TransactionOrderDetail.fromJson(json['order'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'delivery': delivery!.toJson(),
      'reference': reference,
      'transaction_id': transactionId,
      'amount': amount,
      'category': category,
      'status': status,
      'order': commande?.toJson(),
    };
  }
}

class TransactionOrderDetail {
  final int id;
  final String person;
  final String reference;
  final String? detail;
  final int stars;
  final String status;
  final Seller? seller;
  final Client? client;
  final OrderStatus? canceled;
  final OrderStatus? received;
  final OrderStatus? validated;
  final OrderStatus? postponed;
  final OrderStatus? dontPickUp;
  final OrderStatus? pending;
  final OrderStatus? inProgress;
  final OrderStatus? confirmed;
  final List<TransactionOrderItem> items;

  TransactionOrderDetail({
    required this.id,
    required this.person,
    required this.reference,
    this.detail,
    this.canceled,
    this.received,
    this.validated,
    this.postponed,
    this.dontPickUp,
    this.pending,
    this.inProgress,
    this.confirmed,
    required this.stars,
    required this.status,
    required this.seller,
    required this.client,
    required this.items,
  });

  factory TransactionOrderDetail.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<TransactionOrderItem> itemsList =
        itemList.map((i) => TransactionOrderItem.fromJson(i)).toList();

    return TransactionOrderDetail(
      id: json['id'],
      person: json['person'],
      reference: json['reference'],
      detail: json['detail'],
      stars: json['stars'],
      status: json['status'],
      seller: Seller.fromJson(json['seller']),
      client: Client.fromJson(json['client']),
      items: itemsList,
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
      'canceled': canceled?.toJson(),
      'recieved': received?.toJson(),
      'validated': validated?.toJson(),
      'postponed': postponed?.toJson(),
      'dont_pick_up': dontPickUp?.toJson(),
      'pending': pending?.toJson(),
      'in_progress': inProgress?.toJson(),
      'confirmed': confirmed?.toJson(),
      'seller': seller!.toJson(),
      'client': client!.toJson(),
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}

class Seller {
  final int id;
  final User? user;
  final String? firstName;
  final String? lastName;
  final String? job;
  final City? city;

  Seller({
    required this.id,
    this.user,
    required this.firstName,
    required this.lastName,
    required this.job,
    this.city,
  });

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      user: User.fromJson(json['user']),
      firstName: json['first_name'],
      lastName: json['last_name'],
      job: json['job'],
      city: City.fromJson(json['city']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user!.toJson(),
      'first_name': firstName,
      'last_name': lastName,
      'job': job,
      'city': city!.toJson(),
    };
  }
}

class User {
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
}

class City {
  final int id;
  final String name;
  final Country? country;

  City({
    required this.id,
    required this.name,
    required this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: Country.fromJson(json['country']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country!.toJson(),
    };
  }
}

class Country {
  final String code;
  final String currency;
  final String name;
  final String nationality;

  Country({
    required this.code,
    required this.currency,
    required this.name,
    required this.nationality,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      currency: json['currency'],
      name: json['name'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'currency': currency,
      'name': name,
      'nationality': nationality,
    };
  }
}

class Client {
  final String name;
  final String phoneNumber;
  final String? phoneNumber2;

  Client({
    required this.name,
    required this.phoneNumber,
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
      'phone_number_2': phoneNumber2,
    };
  }
}

class TransactionOrderItem {
  String reference;
  int star;
  int? price;
  int quantity;
  int? fees;
  String? size;
  String? color;
  Product? product;
  String status;
  int percentage;
  int orderCommission;
  int sellerCommission;
  int recruiterCommission;
  int focalPointCommission;
  bool payment;
  OrderStatus? canceled;
  OrderStatus? validated;
  int? totalProduct;
  int? totalFees;
  int total;

  TransactionOrderItem({
    required this.reference,
    required this.star,
    this.price,
    required this.quantity,
    this.fees,
    this.size,
    this.color,
    this.product,
    required this.status,
    required this.percentage,
    required this.orderCommission,
    required this.sellerCommission,
    required this.recruiterCommission,
    required this.focalPointCommission,
    required this.payment,
    this.canceled,
    this.validated,
    this.totalProduct,
    this.totalFees,
    required this.total,
  });

  factory TransactionOrderItem.fromJson(Map<String, dynamic> json) {
    return TransactionOrderItem(
      reference: json['reference'],
      star: json['star'],
      price: json['price'],
      quantity: json['quantity'],
      fees: json['fees'],
      size: json['size'],
      color: json['color'],
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
      'product': product!.toJson(),
      'status': status,
      'percentage': percentage,
      'order_commission': orderCommission,
      'seller_commission': sellerCommission,
      'recruiter_commission': recruiterCommission,
      'focal_point_commission': focalPointCommission,
      'payment': payment,
      'canceled': canceled?.toJson(),
      'validated': validated?.toJson(),
      'total_product': totalProduct,
      'total_fees': totalFees,
      'total': total,
    };
  }
}

class Product {
  int id;
  String? approvedOrDisapprovedDate;
  String? reasonDisapproved;
  int publish;
  Shop? shop;
  SubCategory? subCategory;
  State? state;
  int popular;
  int star;
  String? code;
  String category;
  String? name;
  String subTitle;
  String description;
  String alias;
  int outStock;
  int unavailable;
  int invisible;
  int stock;
  int views;
  Price? price;
  List<String>? images;

  Product({
    required this.id,
    this.approvedOrDisapprovedDate,
    this.reasonDisapproved,
    required this.publish,
    required this.shop,
    required this.subCategory,
    required this.state,
    required this.popular,
    required this.star,
    required this.code,
    required this.category,
    required this.name,
    required this.subTitle,
    required this.description,
    required this.alias,
    required this.outStock,
    required this.unavailable,
    required this.invisible,
    required this.stock,
    required this.views,
    required this.price,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      approvedOrDisapprovedDate: json['approved_or_disapproved_date'],
      reasonDisapproved: json['reason_disapproved'],
      publish: json['publish'],
      shop: Shop.fromJson(json['shop']),
      subCategory: SubCategory.fromJson(json['sub_category']),
      state: State.fromJson(json['state']),
      popular: json['popular'],
      star: json['star'],
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
      price: Price.fromJson(json['price']),
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'approved_or_disapproved_date': approvedOrDisapprovedDate,
      'reason_disapproved': reasonDisapproved,
      'publish': publish,
      'shop': shop!.toJson(),
      'sub_category': subCategory!.toJson(),
      'state': state!.toJson(),
      'popular': popular,
      'star': star,
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
      'price': price!.toJson(),
      'images': images,
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

class Shop {
  final int id;
  final String name;
  final City? city;
  final Business? business;

  Shop({
    required this.id,
    required this.name,
    required this.city,
    required this.business,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      name: json['name'],
      city: City.fromJson(json['city']),
      business: Business.fromJson(json['business']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city!.toJson(),
      'business': business!.toJson(),
    };
  }
}

class Business {
  final int id;
  final String logo;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  Business({
    required this.id,
    required this.logo,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      logo: json['logo'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'logo': logo,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
    };
  }
}
 */