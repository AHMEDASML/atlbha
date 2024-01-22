// To parse this JSON data, do
//
//     final detailsSubProductModel = detailsSubProductModelFromJson(jsonString);


class DetailsSubProductModel {
  final bool success;
  final Data data;
  final String message;

  DetailsSubProductModel({
    required this.success,
    required this.data,
    required this.message,
  });

  DetailsSubProductModel copyWith({
    bool? success,
    Data? data,
    String? message,
  }) =>
      DetailsSubProductModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailsSubProductModel.fromJson(Map<String, dynamic> json) => DetailsSubProductModel(
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

  Data({
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

  Data copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? name,
    String? image,
    String? price,
    String? logo,
    String? type,
    String? symbol,
    String? details,
    int? hiddenPrice,
    String? quantity,
    int? subCatId,
    dynamic status,
  }) =>
      Data(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
        image: image ?? this.image,
        price: price ?? this.price,
        logo: logo ?? this.logo,
        type: type ?? this.type,
        symbol: symbol ?? this.symbol,
        details: details ?? this.details,
        hiddenPrice: hiddenPrice ?? this.hiddenPrice,
        quantity: quantity ?? this.quantity,
        subCatId: subCatId ?? this.subCatId,
        status: status ?? this.status,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
