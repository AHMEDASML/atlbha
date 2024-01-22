
class CategoryModel {
  final bool success;
  final Data data;
  final String message;

  CategoryModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
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
  final String logo;
  final List<Scat> scat;

  Data({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.logo,
    required this.scat,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    logo: json["logo"],
    scat: List<Scat>.from(json["scat"].map((x) => Scat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "logo": logo,
    "scat": List<dynamic>.from(scat.map((x) => x.toJson())),
  };
}

class Scat {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String name;
  final int categoryId;
  final List<Branch> branches;

  Scat({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.categoryId,
    required this.branches,
  });

  factory Scat.fromJson(Map<String, dynamic> json) => Scat(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    name: json["name"],
    categoryId: json["category_id"],
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "name": name,
    "category_id": categoryId,
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
  };
}

class Branch {
  final int id;
  final String name;
  final int subCatId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Product> products;

  Branch({
    required this.id,
    required this.name,
    required this.subCatId,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["id"],
    name: json["name"],
    subCatId: json["sub_cat_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "sub_cat_id": subCatId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
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
  final int isList;
  final int subCatId;
  final int branchId;
  final dynamic status;

  Product({
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
    required this.isList,
    required this.subCatId,
    required this.branchId,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
    isList: json["is_list"],
    subCatId: json["sub_cat_id"],
    branchId: json["branch_id"],
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
    "is_list": isList,
    "sub_cat_id": subCatId,
    "branch_id": branchId,
    "status": status,
  };
}
