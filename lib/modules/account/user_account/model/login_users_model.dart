// To parse this JSON data, do
//
//     final loginUsersModel = loginUsersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LoginUsersModel loginUsersModelFromJson(String str) => LoginUsersModel.fromJson(json.decode(str));

String loginUsersModelToJson(LoginUsersModel data) => json.encode(data.toJson());

class LoginUsersModel {
  final String message;
  final bool status;
  final Data data;
  final String token;

  LoginUsersModel({
    required this.message,
    required this.status,
    required this.data,
    required this.token,
  });

  factory LoginUsersModel.fromJson(Map<String, dynamic> json) => LoginUsersModel(
    message: json["message"],
    status: json["status"],
    data: Data.fromJson(json["data"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
    "data": data.toJson(),
    "token": token,
  };
}

class Data {
  final String username;
  final dynamic profileImg;
  final String roleName;
  final String phone;
  final String imageCar;
  final String numberCar;
  final String nameCompany;
  final String locationCompany;

  Data({
    required this.username,
    required this.profileImg,
    required this.roleName,
    required this.phone,
    required this.imageCar,
    required this.numberCar,
    required this.nameCompany,
    required this.locationCompany,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    username: json["username"],
    profileImg: json["profile_img"],
    roleName: json["role_name"],
    phone: json["phone"],
    imageCar: json["image_car"],
    numberCar: json["number_car"],
    nameCompany: json["name_company"],
    locationCompany: json["location_company"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "profile_img": profileImg,
    "role_name": roleName,
    "phone": phone,
    "image_car": imageCar,
    "number_car": numberCar,
    "name_company": nameCompany,
    "location_company": locationCompany,
  };
}
