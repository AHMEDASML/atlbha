

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  final bool success;
  final Data data;
  final String message;

  HomeModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  final String car;
  final List<Ad> ads;
  final List<SuggestionProduct> suggestionProducts;
  final List<Category> categories;

  Data({
    required this.car,
    required this.ads,
    required this.suggestionProducts,
    required this.categories,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    car: json["car"],
    ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
    suggestionProducts: List<SuggestionProduct>.from(json["suggestion_products"].map((x) => SuggestionProduct.fromJson(x))),
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "car": car,
    "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
    "suggestion_products": List<dynamic>.from(suggestionProducts.map((x) => x.toJson())),
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}

class Ad {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int productId;
  final String image;

  Ad({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
    required this.image,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productId: json["product_id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_id": productId,
    "image": image,
  };
}

class Category {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String logo;

  Category({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.logo,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "logo": logo,
  };
}

class SuggestionProduct {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final String image;
  final String price;
  final String logo;
  final String type;
  final String symbol;
  final String details;
  final int hiddenPrice;
  final String quantity;
  final int subCatId;
  final dynamic status;

  SuggestionProduct({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.image,
    required this.price,
    required this.logo,
    required this.type,
    required this.symbol,
    required this.details,
    required this.hiddenPrice,
    required this.quantity,
    required this.subCatId,
    required this.status,
  });

  factory SuggestionProduct.fromJson(Map<String, dynamic> json) => SuggestionProduct(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    image: json["image"],
    price: json["price"],
    logo: json["logo"],
    type: json["type"],
    symbol: json["symbol"],
    details: json["details"],
    hiddenPrice: json["hidden_price"],
    quantity: json["quantity"],
    subCatId: json["sub_cat_id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "image": image,
    "price": price,
    "logo": logo,
    "type": type,
    "symbol": symbol,
    "details": details,
    "hidden_price": hiddenPrice,
    "quantity": quantity,
    "sub_cat_id": subCatId,
    "status": status,
  };
}
