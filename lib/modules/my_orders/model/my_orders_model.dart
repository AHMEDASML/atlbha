// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) => MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  final CurrentRequests currentRequests;
  final CompletedRequests completedRequests;

  MyOrdersModel({
    required this.currentRequests,
    required this.completedRequests,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
    currentRequests: CurrentRequests.fromJson(json["current_requests"]),
    completedRequests: CompletedRequests.fromJson(json["completed_requests"]),
  );

  Map<String, dynamic> toJson() => {
    "current_requests": currentRequests.toJson(),
    "completed_requests": completedRequests.toJson(),
  };
}

class CompletedRequests {
  final List<dynamic> completedCartsRequests;
  final List<dynamic> estimisionRequests;
  final List<dynamic> partsRequests;

  CompletedRequests({
    required this.completedCartsRequests,
    required this.estimisionRequests,
    required this.partsRequests,
  });

  factory CompletedRequests.fromJson(Map<String, dynamic> json) => CompletedRequests(
    completedCartsRequests: List<dynamic>.from(json["completed_carts_requests"].map((x) => x)),
    estimisionRequests: List<dynamic>.from(json["estimision_requests"].map((x) => x)),
    partsRequests: List<dynamic>.from(json["parts_requests"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "completed_carts_requests": List<dynamic>.from(completedCartsRequests.map((x) => x)),
    "estimision_requests": List<dynamic>.from(estimisionRequests.map((x) => x)),
    "parts_requests": List<dynamic>.from(partsRequests.map((x) => x)),
  };
}

class CurrentRequests {
  final List<CurrentCartsRequest> currentCartsRequests;
  final List<EstimisionRequest> estimisionRequests;
  final List<PartsRequest> partsRequests;

  CurrentRequests({
    required this.currentCartsRequests,
    required this.estimisionRequests,
    required this.partsRequests,
  });

  factory CurrentRequests.fromJson(Map<String, dynamic> json) => CurrentRequests(
    currentCartsRequests: List<CurrentCartsRequest>.from(json["current_carts_requests"].map((x) => CurrentCartsRequest.fromJson(x))),
    estimisionRequests: List<EstimisionRequest>.from(json["estimision_requests"].map((x) => EstimisionRequest.fromJson(x))),
    partsRequests: List<PartsRequest>.from(json["parts_requests"].map((x) => PartsRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "current_carts_requests": List<dynamic>.from(currentCartsRequests.map((x) => x.toJson())),
    "estimision_requests": List<dynamic>.from(estimisionRequests.map((x) => x.toJson())),
    "parts_requests": List<dynamic>.from(partsRequests.map((x) => x.toJson())),
  };
}

class CurrentCartsRequest {
  final int id;
  final DateTime date;
  final List<Product> products;
  final int totalCount;

  CurrentCartsRequest({
    required this.id,
    required this.date,
    required this.products,
    required this.totalCount,
  });

  factory CurrentCartsRequest.fromJson(Map<String, dynamic> json) => CurrentCartsRequest(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "total_count": totalCount,
  };
}

class Product {
  final String productName;

  Product({
    required this.productName,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productName: json["product_name"],
  );

  Map<String, dynamic> toJson() => {
    "product_name": productName,
  };
}

class EstimisionRequest {
  final int id;
  final int carId;
  final String money;
  final DateTime date;
  final String location;
  final String description;
  final String nameCar;

  EstimisionRequest({
    required this.id,
    required this.carId,
    required this.money,
    required this.date,
    required this.location,
    required this.description,
    required this.nameCar,
  });

  factory EstimisionRequest.fromJson(Map<String, dynamic> json) => EstimisionRequest(
    id: json["id"],
    carId: json["car_id"],
    money: json["money"],
    date: DateTime.parse(json["date"]),
    location: json["Location"],
    description: json["description"],
    nameCar: json["name_car"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_id": carId,
    "money": money,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "Location": location,
    "description": description,
    "name_car": nameCar,
  };
}

class PartsRequest {
  final int id;
  final int carId;
  final List<Part> parts;
  final String nameCar;

  PartsRequest({
    required this.id,
    required this.carId,
    required this.parts,
    required this.nameCar,
  });

  factory PartsRequest.fromJson(Map<String, dynamic> json) => PartsRequest(
    id: json["id"],
    carId: json["car_id"],
    parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
    nameCar: json["name_car"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "car_id": carId,
    "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
    "name_car": nameCar,
  };
}

class Part {
  final String name;
  final String image;
  final int quantity;

  Part({
    required this.name,
    required this.image,
    required this.quantity,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
    name: json["name"],
    image: json["image"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "quantity": quantity,
  };
}
