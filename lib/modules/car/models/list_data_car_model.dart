import 'dart:convert';

class ListDataCarModel {
  final bool success;
  final List<Datum> data;
  final String message;

  ListDataCarModel({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ListDataCarModel.fromRawJson(String str) => ListDataCarModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListDataCarModel.fromJson(Map<String, dynamic> json) => ListDataCarModel(
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
  final String company;
  final List<Model> models;

  Datum({
    required this.company,
    required this.models,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    company: json["company"],
    models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "company": company,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };
}

class Model {
  final dynamic name;
  final List<String> dates;

  Model({
    required this.name,
    required this.dates,
  });

  factory Model.fromRawJson(String str) => Model.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    name: json["name"],
    dates: List<String>.from(json["dates"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "dates": List<dynamic>.from(dates.map((x) => x)),
  };
}
