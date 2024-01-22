// To parse this JSON data, do
//
//     final myCarsModel = myCarsModelFromJson(jsonString);

import 'dart:convert';

MyCarsModel myCarsModelFromJson(String str) => MyCarsModel.fromJson(json.decode(str));

String myCarsModelToJson(MyCarsModel data) => json.encode(data.toJson());

class MyCarsModel {
  final bool success;
  final List<Datum> data;
  final String message;

  MyCarsModel({
    required this.success,
    required this.data,
    required this.message,
  });

  MyCarsModel copyWith({
    bool? success,
    List<Datum>? data,
    String? message,
  }) =>
      MyCarsModel(
        success: success ?? this.success,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory MyCarsModel.fromJson(Map<String, dynamic> json) => MyCarsModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final String company;
  final String year;
  final String model;
  final String number;
  final String status;

  Datum({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.company,
    required this.year,
    required this.model,
    required this.number,
    required this.status,
  });

  Datum copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? userId,
    String? company,
    String? year,
    String? model,
    String? number,
    String? status,
  }) =>
      Datum(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        company: company ?? this.company,
        year: year ?? this.year,
        model: model ?? this.model,
        number: number ?? this.number,
        status: status ?? this.status,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    userId: json["user_id"],
    company: json["company"],
    year: json["year"],
    model: json["model"],
    number: json["number"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user_id": userId,
    "company": company,
    "year": year,
    "model": model,
    "number": number,
    "status": status,
  };
}
