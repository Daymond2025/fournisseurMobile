class Product {
  final int? id;
  final String? approvedOrDisapprovedDate;
  final String? reasonDisapproved;
  final int? publish;
  final Shop? shop;
  final SubCategory? subCategory;
  final States? state;
  final String? brand;
  final int? popular;
  final int? star;
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
  final int? orderstock;
  final int? totalstock;
  final int? views;
  final String? link;
  final Price? price;
  final PriceDelivery? priceDelivery;
  final List<String>? images;
  final List<String>? sizes;
  final List<String>? colors;
  final String? createdAt;
  final String? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

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
    this.totalstock,
    this.orderstock,
    this.views,
    this.link,
    this.price,
    this.priceDelivery,
    this.images,
    this.sizes,
    this.colors,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
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
      state: json['state'] != null ? States.fromJson(json['state']) : null,
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
      totalstock: json['total_stock'],
      orderstock: json['order_stock'],
      views: json['views'],
      link: json['link'],
      price: json['price'] != null ? Price.fromJson(json['price']) : null,
      priceDelivery: json['price_delivery'] != null
          ? PriceDelivery.fromJson(json['price_delivery'])
          : null,
      images:
          (json['images'] != null) ? List<String>.from(json['images']) : null,
      sizes: (json['sizes'] != null) ? List<String>.from(json['sizes']) : null,
      colors:
          (json['colors'] != null) ? List<String>.from(json['colors']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
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
      'link': link,
      'price': price?.toJson(),
      'price_delivery': priceDelivery?.toJson(),
      'images': images,
      'sizes': sizes,
      'colors': colors,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}

class Shop {
  final int? id;
  final String? code;
  final City? city;
  final Business? business;
  final String? address;
  final String? createdAt;
  final String? updatedAt;
  final String? createdAtFr;
  final String? updatedAtFr;

  Shop({
    this.id,
    this.code,
    this.city,
    this.business,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.createdAtFr,
    this.updatedAtFr,
  });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      id: json['id'],
      code: json['code'],
      city: json['city'] != null ? City.fromJson(json['city']) : null,
      business:
          json['business'] != null ? Business.fromJson(json['business']) : null,
      address: json['address'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      createdAtFr: json['created_at_fr'],
      updatedAtFr: json['updated_at_fr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'city': city?.toJson(),
      'business': business?.toJson(),
      'address': address,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'created_at_fr': createdAtFr,
      'updated_at_fr': updatedAtFr,
    };
  }
}

class City {
  final int? id;
  final String? name;
  final Country? country;

  City({this.id, this.name, this.country});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country:
          json['country'] != null ? Country.fromJson(json['country']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'country': country?.toJson(),
    };
  }
}

class Country {
  final String? flag;
  final String? code;
  final String? currency;
  final String? name;
  final String? nationality;

  Country({this.flag, this.code, this.currency, this.name, this.nationality});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      flag: json['flag'],
      code: json['code'],
      currency: json['currency'],
      name: json['name'],
      nationality: json['nationality'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flag': flag,
      'code': code,
      'currency': currency,
      'name': name,
      'nationality': nationality,
    };
  }
}

class Business {
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

  Business({
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

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      logo: json['logo'],
      name: json['name'],
      ncc: json['ncc'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      registersPath: (json['registers_path'] != null)
          ? List<String>.from(json['registers_path'])
          : null,
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

class SubCategory {
  final String? name;

  SubCategory({this.name});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class States {
  final int? id;
  final String? name;

  States({this.name, this.id});

  factory States.fromJson(Map<String, dynamic> json) {
    return States(
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'id': id};
  }
}

class Price {
  final int? price;
  final int? partner;
  final int? supplier;
  final int? seller;
  final int? max;
  final int? min;
  final int? commission;

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

class PriceDelivery {
  final int? value;

  PriceDelivery({this.value});

  factory PriceDelivery.fromJson(Map<String, dynamic> json) {
    return PriceDelivery(
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value};
  }
}
