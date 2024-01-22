import 'dart:convert';

import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/car/models/my_cars_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../global/data/local/cache_helper.dart';
import '../../../../global/endpoints/url_api.dart';
import '../../../../global/utils/key_shared.dart';

String? selectedCar;
Future<List<dynamic>> fetchCarCompanies() async {
  final token = CacheHelper.getData(key: TOKEN);

  final response = await http.get(
    Uri.parse(myCarsUrl),
    headers: {
      // 'Authorization': 'Bearer $token',
      'Authorization':
          'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> cars = data['data'];

    if(selectedCar==null){

      try {
        selectedCar = data['data'][0]["id"].toString();
      } catch (ex) {

      }
    }

    // استخدام Set بدلاً من List لضمان عدم وجود قيم مكررة
    // final List<String> companies =
    //     List.from(cars.map((car) => car['company'].toString()));
    // companies.add("Other");
    return cars; // تحويل الSet إلى List
  } else {
    throw Exception('Failed to load car companies');
  }
}


Widget selectCarWidget(
    {required BuildContext context,
    required Function(String? selectedCar) onCarSelected,
    Function(String? selectedCarId)? onCarSelectedId}) {
  void showNoCarAddedMessage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return Container(
          height:
          MediaQuery.of(context).size.height * 0.7, // 70% of screen height
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipOval(
                  child: Image.asset(
                    ImageApp.beforeLoggingIn,
                    width: 200,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 30),
                TextBoldeWidget(text: 'No car has been added'.tr, fontSize: 20),
              ],
            ),
          ),
        );
      },
    );
  }


  return StatefulBuilder(
    builder: (BuildContext context, StateSetter setState) {
      return GestureDetector(
        onTap: () {
          if (selectedCar == null) {
            showNoCarAddedMessage(context);
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.withOpacity(0.8)),
          ),
          child: FutureBuilder<List<dynamic>>(
            future: fetchCarCompanies(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          Text('Loading ...'.tr),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 32,
                          color: ColorManager.yellow2,
                        ),
                      ],
                    ),
                  ),
                );
                // return SizedBox();
              } else if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return Container(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Text('There are no cars yet, add a car'.tr));
              } else {
                final List<String> companies = List.from(
                    snapshot.data!.map((car) => car['company'].toString()));
                // List<String> companies = snapshot.data ?? [];
                return DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCar,
                    isExpanded: true,
                    iconEnabledColor: ColorManager.yellow2,
                    iconSize: 32,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    items: snapshot.data!.map((car) {
                      return DropdownMenuItem<String>(
                        value: car['id'].toString(),
                        child: Row(
                          children: [
                            Icon(Icons.directions_car,
                                color: ColorManager.yellow2),
                            // Yellow car icon
                            const SizedBox(width: 10),
                            Text(car['company']),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      onCarSelected(newValue);
                      // print(newValue);
                      // إيجاد الـ id المتعلق بالشركة المختارة
                      // var selectedCarData = snapshot.data!.firstWhere((car) => car['id'] == newValue);
                      // String selectedCarId = selectedCarData['id'].toString();
                      if (onCarSelectedId != null) {
                        onCarSelectedId(newValue);
                      }
                      setState(() {
                        selectedCar = newValue;
                      });
                    },
                  ),
                );
              }
            },
          ),
        ),
      );
    },
  );
}

Widget iconSparePartsRequests({required Widget icon, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.8)),
        borderRadius: BorderRadius.circular(4),
        color: ColorManager.white,
      ),
      child: icon,
    ),
  );
}

Widget textFieldSpareParts({TextEditingController? controller}) {
  return TextField(
    controller: controller,
    textAlign: TextAlign.center, // Centers the cursor and text
    cursorColor: ColorManager.yellow2, // Sets the cursor color to yellow
    style: TextStyle(
      color: ColorManager.black, // Text color
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.black),
        borderRadius: BorderRadius.zero,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.yellow2),
        borderRadius: BorderRadius.zero,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.black),
        borderRadius: BorderRadius.zero,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
    ),
  );
}

Widget addAnotherPieceWidget() {
  return Container(
    width: SizeApp.screenSize.width,
    height: 50,
    decoration: BoxDecoration(
        border: Border.all(color: ColorManager.grey2.withOpacity(0.2)),
        color: ColorManager.blueGrey2.withOpacity(0.1)),
    child: Center(
        child: TextBoldeWidget(
      text: 'Add another piece'.tr,
      fontSize: 22,
      fontWeight: FontWeight.w400,
    )),
  );
}
