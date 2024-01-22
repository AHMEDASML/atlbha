import 'dart:convert';

import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';

import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/car/models/list_data_car_model.dart';
import 'package:atlobha/modules/car/models/my_cars_model.dart';

import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarController extends GetxController {


  String selectedCompany = '';
  String selectedModel = '';
  String selectedYear = '1997';
  String chassisNumber = '';



  void setSelectedCompany(String company) {
    selectedCompany = company;
    currentModels.clear();
    currentDates.clear();

    var companyData = listDataCarModel?.data.firstWhere((datum) => datum.company == company);
    if (companyData != null) {
      currentModels.addAll(companyData.models.map((m) => m.name));
      if (currentModels.isNotEmpty) {
        setSelectedModel(currentModels.first);
      }
    }
    update();
  }

  void setSelectedModel(String model) {
    selectedModel = model;
    currentDates.clear();

    var companyData = listDataCarModel?.data.firstWhere((datum) => datum.company == selectedCompany,
        );
    var modelData = companyData?.models.firstWhere((m) => m.name == model);
    if (modelData != null) {
      currentDates.addAll(modelData.dates.map((d) => d.toString()));
      if (currentDates.isNotEmpty) {
        selectedYear = currentDates.first;
      }
    }
    update();
  }

  void setSelectedYear(String year) {
    selectedYear = year;
    update();
  }

  void setChassisNumber(String number) {
    chassisNumber = number;
    update();
  }
  List<String> currentModels = [];
  List<String> currentDates = [];


  bool loading = false;
  final token = CacheHelper.getData(key: TOKEN);
  // final token = '1|zTFTMwt7fhm3TXltTLNonrVIYDbs9ORjB1m8Jh2jb458eddc';
  MyCarsModel? myCarsModel;
  final List<String> dataProduct = [
    '1997',
  ];


  final List<String> nameProduct = [];

  final List<String> nameModelProduct = ['m1'];
  ListDataCarModel? listDataCarModel;

  Future<void>getListDataCar()async{
    var dio = Dio();
    var response = await dio.request(
      listDataCarUrl,
      options: Options(
        method: 'GET',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      listDataCarModel = ListDataCarModel.fromJson(response.data);

      // Clear existing data
      nameProduct.clear();
      nameModelProduct.clear();
      dataProduct.clear();
      update();



      if (listDataCarModel != null && listDataCarModel!.data.isNotEmpty) {
         nameProduct.clear();
        nameModelProduct.clear();
        dataProduct.clear();
         update();

         nameProduct.clear(); // Clear existing data
         // for (var datum in data) {
         //   nameProduct.add(datum.company); // Assuming datum.company is a String
         // }
        for (var datum in listDataCarModel!.data) {
          nameProduct.add(datum.company);
          for (var model in datum.models) {
            String modelName = model.name is String ? model.name : model.name.toString();
            nameModelProduct.add(modelName);
            for (var date in model.dates) {
              String dateString = date is int ? date.toString() : date;
              dataProduct.add(dateString);
            }
          }
        }

        update();
      }
       print(listDataCarModel!.data.first.models.first.name);
      update();
    }
    else {
      print(response.statusMessage);
      update();
    }
  }


Future<void> deleteCar({required int id})async{
  setLoading(true);
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var dio = Dio();
  var response = await dio.request(
    '$deleteCarUrl$id',
    options: Options(
      method: 'POST',
      headers: headers,
    ),
  );

  if (response.statusCode == 200) {
    print(json.encode(response.data));
    setLoading(false);
  }
  else {
    print(response.statusMessage);
    setLoading(false);
  }
}

 Future<void>defaultCar({required int id})async{

   var headers = {
     'Authorization': 'Bearer $token'
   };
   var dio = Dio();
   var response = await dio.request(
     '$defaultCarUrl$id',
     options: Options(
       method: 'POST',
       headers: headers,
     ),
   );

   if (response.statusCode == 200) {
     print(json.encode(response.data));
   }
   else {
     print(response.statusMessage);
   }

 }


  Future<void> getMyCars() async {
    setLoading(true);
    var headers = {
      'Authorization':
          'Bearer $token'
    };
    var dio = Dio();
    var response = await dio.request(
      myCarsUrl,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      myCarsModel = MyCarsModel.fromJson(response.data);
      print('AAAAAAAAAAA11111');
      setLoading(false);
    } else {
      print(response.statusMessage);
      setLoading(false);
    }
  }

  @override
  void onInit() {
    getListDataCar();
    super.onInit();
  }

  Future<void> addCar({
    required BuildContext context,
    required String company,
    required String year,
    required String model,
    required int number,
  }) async {
    setLoading(true);

    var headers = {
      'Authorization':
          'Bearer $token'
    };
    var data = json.encode({
      'company': company,
      'year': year,
      'model': model,
      'number': number,
      'status': 'default'
    });

    var dio = Dio();
    var response = await dio.request(
      addCarUrl,
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));

      showToastApp(
          text: 'The car has been added', color: ColorManager.green);

      setLoading(false);
      navigateAndFinish(context, LayoutScreen());
    } else {
      print(response.statusMessage);
      showToastApp(text: 'Try again', color: Colors.red);
      setLoading(false);
    }
  }

  void setLoading(bool status) {
    loading = status;
    update();
  }
}
