import 'dart:convert';

class Products {
  final int id;
  final int createdBy;
  final int? approvedOrDisapprovedBy;
  final String? approvedOrDisapprovedDate;
  final String? reasonDisapproved;
  final int? publish;
  final int shopId;
  final int subCategoryId;
  final int stateId;
  final int? brandId;
  final int popular;
  final int star;
  final String code;
  final String category;
  final String name;
  final String subTitle;
  final String description;
  final String alias;
  final int outStock;
  final int unavailable;
  final int invisible;
  final int stock;
  final int views;
  final String? link;
  final int price;
  final int? pricePartner;
  final int? priceSupplier;
  final int? priceSeller;
  final int? priceMax;
  final int? priceMin;
  final int? commission;
  final int? priceCityDelivery;
  final int? priceNoCityDelivery;
  final List<String> images;
  final List<String>? sizes;
  final List<String>? colors;
  final String createdAt;
  final String updatedAt;

  Products({
    required this.id,
    required this.createdBy,
    this.approvedOrDisapprovedBy,
    this.approvedOrDisapprovedDate,
    this.reasonDisapproved,
    this.publish,
    required this.shopId,
    required this.subCategoryId,
    required this.stateId,
    this.brandId,
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
    this.link,
    required this.price,
    this.pricePartner,
    this.priceSupplier,
    this.priceSeller,
    this.priceMax,
    this.priceMin,
    this.commission,
    this.priceCityDelivery,
    this.priceNoCityDelivery,
    required this.images,
    this.sizes,
    this.colors,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      createdBy: json['created_by'],
      approvedOrDisapprovedBy: json['approved_or_disapproved_by'],
      approvedOrDisapprovedDate: json['approved_or_disapproved_date'],
      reasonDisapproved: json['reason_disapproved'],
      publish: json['publish'],
      shopId: json['shop_id'],
      subCategoryId: json['sub_category_id'],
      stateId: json['state_id'],
      brandId: json['brand_id'],
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
      link: json['link'],
      price: json['price'],
      pricePartner: json['price_partner'],
      priceSupplier: json['price_supplier'],
      priceSeller: json['price_seller'],
      priceMax: json['price_max'],
      priceMin: json['price_min'],
      commission: json['commission'],
      priceCityDelivery: json['price_city_​delivery'],
      priceNoCityDelivery: json['price_no_city_​delivery'],
      images: List<String>.from(jsonDecode(json['images'])),
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : null,
      colors: json['colors'] != null ? List<String>.from(json['colors']) : null,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_by': createdBy,
      'approved_or_disapproved_by': approvedOrDisapprovedBy,
      'approved_or_disapproved_date': approvedOrDisapprovedDate,
      'reason_disapproved': reasonDisapproved,
      'publish': publish,
      'shop_id': shopId,
      'sub_category_id': subCategoryId,
      'state_id': stateId,
      'brand_id': brandId,
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
      'price': price,
      'price_partner': pricePartner,
      'price_supplier': priceSupplier,
      'price_seller': priceSeller,
      'price_max': priceMax,
      'price_min': priceMin,
      'commission': commission,
      'price_city_​delivery': priceCityDelivery,
      'price_no_city_​delivery': priceNoCityDelivery,
      'images': jsonEncode(images),
      'sizes': sizes,
      'colors': colors,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
