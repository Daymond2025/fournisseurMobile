/* class OrderModel {
  String? brand;
  int? popular;
  int? star;
  String? code;
  String? category;
  String? name;
  String? subTitle;
  String? description;
  String? alias;
  int? outStock;
  int? unavailable;
  int? invisible;
  int? stock;
  String? createdate;
  int? views;
  String? link;
  Price? price;
  PriceDelivery? priceDelivery;
  List<String>? images;

  int? id;
  String? person;
  String? reference;
  dynamic detail;
  int? stars;
  String? status;
  int? returned;
  Seller? seller;
  dynamic client;
  List<Item>? items;
  Delivery? delivery;
  Expedition? expedition;
  StatusUpdate? confirmed;

  OrderModel({
    this.brand,
    this.popular,
    this.star,
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
    this.id,
    this.person,
    this.reference,
    this.detail,
    this.stars,
    this.status,
    this.returned,
    this.seller,
    this.client,
    this.items,
    this.delivery,
    this.expedition,
    this.createdate,
    this.confirmed,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      person: json['person'],
      reference: json['reference'],
      detail: json['detail'],
      stars: json['stars'],
      status: json['status'],
      returned: json['returned'],
      seller: json['seller'] != null ? Seller.fromJson(json['seller']) : null,
      client: json['client'],
      items: json['items'] != null
          ? List<Item>.from(json['items'].map((x) => Item.fromJson(x)))
          : null,
      delivery:
          json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null,
      expedition: json['expedition'] != null
          ? Expedition.fromJson(json['expedition'])
          : null,
      confirmed: json['confirmed'] != null
          ? StatusUpdate.fromJson(json['confirmed'])
          : null,
      brand: json['brand'],
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
      createdate: json['created_at'],
      views: json['views'],
      link: json['link'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      priceDelivery: json['price_delivery'] != null
          ? PriceDelivery.fromJson(json['price_delivery'])
          : null,
      images: List<String>.from(json['images'] ?? []),
    );
  }
}

class Price {
  int? price;
  int? partner;
  int? supplier;
  int? seller;
  int? max;
  int? min;
  int? commission;

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
      commission: json['commission'],
    );
  }
}

class PriceDelivery {
  String? city;
  String? noCity;

  PriceDelivery({this.city, this.noCity});

  factory PriceDelivery.fromJson(Map<String, dynamic> json) {
    return PriceDelivery(
      city: json['city'],
      noCity: json['no_city'],
    );
  }
}

// Other nested models (Seller, Item, Delivery, etc.) would follow a similar structure
class Seller {
  int? id;
  User? user;
  String? firstName;
  String? lastName;
  City? city;
  int? stars;

  Seller(
      {this.id,
      this.user,
      this.firstName,
      this.lastName,
      this.city,
      this.stars});

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      firstName: json['first_name'],
      lastName: json['last_name'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      stars: json['stars'],
    );
  }
}

class User {
  int? id;
  String? email;
  String? phoneNumber;

  User({this.id, this.email, this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}

class Item {
  String? reference;
  int? star;
  int? price;
  int? quantity;

  Item({this.reference, this.star, this.price, this.quantity});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      reference: json['reference'],
      star: json['star'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

// Add similar classes for City, Delivery, Expedition, etc.
class City {
  int? id;
  String? name;
  String? region;

  City({this.id, this.name, this.region});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      region: json['region'],
    );
  }
}

class Delivery {
  int? id;
  String? mode;
  String? deliveryDate;
  int? cost;

  Delivery({this.id, this.mode, this.deliveryDate, this.cost});

  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      mode: json['mode'],
      deliveryDate: json['delivery_date'],
      cost: json['cost'],
    );
  }
}

class Expedition {
  int? id;
  String? expeditionMode;
  String? trackingNumber;

  Expedition({this.id, this.expeditionMode, this.trackingNumber});

  factory Expedition.fromJson(Map<String, dynamic> json) {
    return Expedition(
      id: json['id'],
      expeditionMode: json['expedition_mode'],
      trackingNumber: json['tracking_number'],
    );
  }
}

class StatusUpdate {
  int? id;
  String? status;
  String? updatedAt;

  StatusUpdate({this.id, this.status, this.updatedAt});

  factory StatusUpdate.fromJson(Map<String, dynamic> json) {
    return StatusUpdate(
      id: json['id'],
      status: json['status'],
      updatedAt: json['updated_at'],
    );
  }
}
 */