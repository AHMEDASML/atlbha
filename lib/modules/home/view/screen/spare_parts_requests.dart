import 'dart:convert';
import 'dart:io';

import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/message_error_widget.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/car/controller/car_controller.dart';
import 'package:atlobha/modules/car/models/my_cars_model.dart';
import 'package:atlobha/modules/car/view/screen/add_car_screen.dart';
import 'package:atlobha/modules/home/view/widget/element_item_widget.dart';
import 'package:atlobha/modules/home/view/widget/spare_parts_requests_widget.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:atlobha/modules/setting/view/widget/widget_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../global/data/local/cache_helper.dart';
import '../../../../global/utils/key_shared.dart';

class SparePartsRequests extends StatefulWidget {
  const SparePartsRequests({Key? key}) : super(key: key);

  @override
  State<SparePartsRequests> createState() => _SparePartsRequestsState();
}

class _SparePartsRequestsState extends State<SparePartsRequests> {
  String? selectedCar;


  final cont = Get.put(CarController());

  List<Widget> elementItems = [];
  List<int> itemNumbers = [];
  List<File?> itemImages = [];
  Map<int, GlobalKey> itemKeys = {};
  List<TextEditingController> textControllers = [];
  final token = CacheHelper.getData(key: TOKEN);
  int nextId = 0;

  void addElementItem() {
    TextEditingController newController = TextEditingController();
    int currentId = nextId++;
    GlobalKey newItemKey = GlobalKey(); // Create a new GlobalKey for the widget

    setState(() {
      textControllers.add(newController);
      itemNumbers.add(1);
      itemImages.add(null);
      itemKeys[currentId] = newItemKey; // Associate the key with the ID

      elementItems.add(ElementItemWidget(
        key: newItemKey,
        onRemove: () => removeElementItem(newItemKey),
        textController: newController,
        onNumberChanged: (number) {
          int index = itemKeys.entries
              .firstWhere((entry) => entry.value == newItemKey)
              .key;
          itemNumbers[index] = number;
        },
        onImageChanged: (image) {
          int index = itemKeys.entries
              .firstWhere((entry) => entry.value == newItemKey)
              .key;
          itemImages[index] = image;
        },
        id: currentId,
      ));
    });
  }

  void removeElementItem(GlobalKey key) {
    setState(() {
      int indexToRemove =
          itemKeys.entries.firstWhere((entry) => entry.value == key).key ?? -1;
      if (indexToRemove != -1) {
        textControllers.removeAt(indexToRemove);
        elementItems.removeAt(indexToRemove);
        itemNumbers.removeAt(indexToRemove);
        itemImages.removeAt(indexToRemove);
        itemKeys.remove(indexToRemove);
      }
    });
  }

  void assignCarCompanies(MyCarsModel model, List<String> cars) {
    for (int i = 0; i < model.data.length; i++) {
      if (i < cars.length) {
        model.data[i] = model.data[i].copyWith(company: cars[i]);
      }
    }
  }

  bool isLoading = false;
  void postData({
    required String selectedCar,
    required List<TextEditingController> textControllers,
    required List<int> itemNumbers,
    required List<File?> itemImages,
  }) async {

    isLoading = true;

    var uri =
        Uri.parse(requestParts);
    // var request = http.MultipartRequest('POST', uri);
    // List<List<int>> imageBytesList = [];
    // for (var imageFile in itemImages) {
    //   if (imageFile != null) {
    //     List<int> imageBytes = await imageFile.readAsBytes();
    //     imageBytesList.add(imageBytes);
    //   }
    // }
    // // تكوين قائمة الأجزاء
    // List<Map<String, dynamic>> partsList = [];
    //
    // for (int i = 0; i < textControllers.length; i++) {
    //
    //   Map<String, dynamic> part = {
    //     'name': 'p${i + 1}',
    //     'quantity': itemNumbers[i],
    //   };
    //
    //   if (i < imageBytesList.length) {
    //     part['image'] = base64Encode(imageBytesList[i]);
    //   }
    //
    //   partsList.add(part);
    // }

    // request.fields['car_id'] = selectedCar;
    // request.fields['date'] = date;
    // request.fields['money'] = money;
    // request.fields['Location'] = Location;

    // request.headers['Authorization'] = "Bearer t7wiULR3Umkfu2jOymbpeWCcLmAur6r6IFhzsSut997300a3";

    // request.headers['Authorization'] =
    // "Bearer ${CacheHelper.getData(key: TOKEN)}";
    //
    // var response = await request.send();

    final List<Map<String, dynamic>> parts = [];

    // يتم التحقق مما إذا كان هناك تحكم نصي ورقمي وصورة للعنصر نفسه
    for (int i = 0; i < textControllers.length; i++) {
      final String name = textControllers[i].text;
      final int quantity = itemNumbers[i];
      final File? image = itemImages[i];

      final Map<String, dynamic> part = {
        'name': name,
        'quantity': quantity,
        'image': image?.path,
      };

      parts.add(part);
    }

    final carId = selectedCar;
    print("selectedCar$selectedCar");

    final Map<String, dynamic> requestBody = {
      'parts': parts,
      'car_id': carId,
    };
    final headers = {
      'Content-Type': 'application/json',
      'Authorization':
          "Bearer $token",
    };

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(requestBody),
      );
        isLoading = false;


      if (response.statusCode == 200) {
        print('Success: ${response.body}');

        showToastApp(text: "تم ارسال الطلب",color: Colors.green);
        Get.to(LayoutScreen());
      } else {
        print('Error: ${response.statusCode}, ${response.body}');

        showToastApp(text: "فشل في ارسال الطلب");
      }
    } catch (error) {
      print('Error: $error');
      showToastApp(text: "فشل في ارسال الطلب");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: TextBoldeWidget(text: 'Spare parts'.tr, fontSize: 20),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 80,
        decoration: BoxDecoration(
          color: ColorManager.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: const Offset(0.0, 0)),
          ],
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : ButtonAppGold(
                onTap: () {

                  if (token == null) {
                    showFlashError(
                        context: context,
                        message: 'يجب تسجيل الدخول اولا ');
                    return;
                  }


                  if(selectedCar == null){
                    showToastApp(text: "يجب اختيار السيارة اولا");
                  }else{

                    postData(
                        selectedCar: selectedCar!,
                        itemImages: itemImages,
                        itemNumbers: itemNumbers,
                        textControllers: textControllers);
                    for (int i = 0; i < textControllers.length; i++) {
                      print("Item ${i + 1}:");
                      print("Number: ${itemNumbers[i]}");
                      print("Text: ${textControllers[i].text}");
                      if (itemImages[i] != null) {
                        print("Image path: ${itemImages[i]!.path}");
                      } else {
                        print("Image path: No image selected");
                      }
                    }
                  }

                },
                height: 50,
                text: 'Order pricing'.tr,
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: SizedBox(
          width: SizeApp.screenSize.width,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextBoldeWidget(text: 'Vehicle information'.tr, fontSize: 20),
              const SizedBox(
                height: 10,
              ),
              TextNourmalWidget(
                text: 'Select your vehicle'.tr,
                fontSize: 18,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: selectCarWidget(
                      context: context,
                      onCarSelected: (String? car) {},
                      onCarSelectedId: (String? selectedCarId) {
                        selectedCar = selectedCarId;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  iconSparePartsRequests(
                      onTap: () {
                        if (token == null) {
                          showFlashError(
                              context: context,
                              message: 'يجب تسجيل الدخول اولا ');
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCarScreen()),);
                        // navigateTo(context, AddCarScreen());
                      },
                      icon: const Icon(
                        Icons.car_repair_outlined,
                        size: 30,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.grey.withOpacity(0.3),
                height: 5,
                width: SizeApp.screenSize.width,
              ),
              const SizedBox(
                height: 10,
              ),
              TextBoldeWidget(text: 'Parts data'.tr, fontSize: 20),
              const SizedBox(
                height: 10,
              ),
              TextNourmalWidget(
                text: 'Name or number of the part'.tr,
                fontSize: 18,
              ),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < elementItems.length; i++)
                ElementItemWidget(
                  textController: textControllers[i],
                  key: elementItems[i].key,
                  onRemove: () => removeElementItem(
                      textControllers[i] as GlobalKey<State<StatefulWidget>>),
                  // Pass the correct controller
                  onNumberChanged: (number) => itemNumbers[i] = number,
                  onImageChanged: (image) => itemImages[i] = image,
                  id: i, // Since we're iterating, 'i' can serve as a unique ID
                ),
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: addElementItem,
                child: addAnotherPieceWidget(),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
