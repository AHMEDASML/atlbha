import 'dart:io';

import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/components/appbar_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/message_error_widget.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/car/controller/car_controller.dart';
import 'package:atlobha/modules/car/view/screen/add_car_screen.dart';
import 'package:atlobha/modules/home/view/widget/spare_parts_requests_widget.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../global/common/loading_app.dart';
import '../../../global/data/local/cache_helper.dart';
import '../../../global/endpoints/url_api.dart';
import '../../../global/utils/key_shared.dart';

class EstimateRequestScreen extends StatefulWidget {
  const EstimateRequestScreen({Key? key}) : super(key: key);

  @override
  State<EstimateRequestScreen> createState() => _EstimateRequestScreenState();
}

class _EstimateRequestScreenState extends State<EstimateRequestScreen> {
  final cont = Get.put(CarController());
  final token = CacheHelper.getData(key: TOKEN);
  TextEditingController _noteController = TextEditingController();

  String? selectedCar;
  String? pdfPath;
  String? photoPath;
  DateTime? selectedDate;

  String pdfText = "Download the accident report".tr;
  String photoText = "Download the photo of the accident".tr;

  bool isLoading = false;

  void postData({
    required String selectedCar,
    required String description,
    required String report,
    required String image,
    required String date,
    required String money,
    required String Location,
  }) async {
    try {
      setState(() {
        isLoading = true;
      });
      var uri = Uri.parse(
          "$requestEstimation$selectedCar"); // استبدله بعنوان النهاية الفعلي
      var request = http.MultipartRequest('POST', uri);

      // إضافة متغيرات النص إلى الطلب
      request.fields['description'] = description;
      request.fields['date'] = date; // تحويل التاريخ إلى سلسلة نصية
      request.fields['money'] = money; // تحويل التاريخ إلى سلسلة نصية
      request.fields['Location'] = Location; // تحويل التاريخ إلى سلسلة نصية

      // إضافة ملف PDF
      request.files.add(
        await http.MultipartFile.fromPath('report', report),
      );

      // إضافة ملف الصورة
      request.files.add(
        await http.MultipartFile.fromPath('image', image),
      );

      // request.headers['Authorization'] = "Bearer t7wiULR3Umkfu2jOymbpeWCcLmAur6r6IFhzsSut997300a3";
      request.headers['Authorization'] =
          "Bearer ${CacheHelper.getData(key: TOKEN)}";

      var response = await request.send();
      setState(() {
        isLoading = false;
      });
      if (response.statusCode == 200) {
        print('Post request successful');
        showToastApp(text: "تم ارسال الطلب", color: Colors.green);
        Get.to(const LayoutScreen());
      } else {
        print('Post request failed with status ${response.statusCode}');
        showToastApp(text: "فشل في ارسال الطلب");
      }
    } catch (e) {
      print('Error during post request: $e');
      showToastApp(text: "فشل في ارسال الطلب");
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> uploadPdf(Function(String? selectedPDF) onPDFSelected) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);

        onPDFSelected(file.path);
        setState(() {
          pdfText = result.files.single.name!;
        });
      }
    }

    Future<void> uploadPhoto(
        Function(String? selectedPhoto) onPhotoSelected) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        File file = File(result.files.single.path!);
        onPhotoSelected(file.path);
        setState(() {
          photoText = result.files.single.name!;
        });
        // Perform file upload to API
        // try {
        //   var request = http.MultipartRequest(
        //     'POST',
        //     Uri.parse('YOUR_API_ENDPOINT'),
        //   );
        //
        //   request.files.add(await http.MultipartFile.fromPath(
        //     'pdf_file',
        //     file.path,
        //   ));
        //
        //   var response = await request.send();
        //
        //   if (response.statusCode == 200) {
        //     print('File uploaded successfully');
        //   } else {
        //     print('File upload failed with status ${response.statusCode}');
        //   }
        // } catch (e) {
        //   print('Error uploading file: $e');
        // }
      }
    }

    Widget itemUploadPDFRequest(
        {required String text,
        IconData? icon,
        required Function(String? selectedPDF) onPDFSelected}) {
      return GestureDetector(
        onTap: () {
          uploadPdf((selectedPDF) => onPDFSelected(selectedPDF));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              color: Colors.grey.withOpacity(0.1)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextNourmalWidget(
              text: text,
              fontSize: 18,
            ),
            icon == null ? Container() : Icon(icon)
          ]),
        ),
      );
    }

    Widget itemUploadPhotoRequest(
        {required String text,
        IconData? icon,
        required Function(String? selectedPhoto) onPhotoSelected}) {
      return GestureDetector(
        onTap: () {
          uploadPhoto((selectedPhoto) => onPhotoSelected(selectedPhoto));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              color: Colors.grey.withOpacity(0.1)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            TextNourmalWidget(
              text: text,
              fontSize: 18,
            ),
            icon == null ? Container() : Icon(icon)
          ]),
        ),
      );
    }

    return Scaffold(
      bottomNavigationBar: isLoading
          ? loadingAppWidget()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              child: ButtonAppGold(
                onTap: () {
                  if (token == null) {
                    showFlashError(
                        context: context, message: 'يجب تسجيل الدخول اولا ');
                    return;
                  }
                  String enteredText = _noteController.text;
                  if (selectedCar != null &&
                      pdfPath != null &&
                      photoPath != null &&
                      selectedDate != null) {
                    // تنفيذ الإجراء عندما تكون جميع القيم غير null
                    // print('Entered text: $enteredText');
                    // print('Entered pdf: $pdfPath');
                    // print('Entered photo: $photoPath');
                    // print('Entered date: ${selectedDate.toString()}');

                    postData(
                        selectedCar: selectedCar!,
                        description: enteredText,
                        report: pdfPath!,
                        image: photoPath!,
                        date: selectedDate.toString(),
                        money: "4954",
                        Location: "Damascus");

                    // قد تقوم هنا بتنفيذ المزيد من العمليات أو استدعاء الوظائف اللازمة
                  } else {
                    // رسالة أو إجراء عندما تكون أحد القيم هي null
                    print('One or more values are null');
                  }
                },
                height: 50,
                text: 'Complete the request'.tr,
              ),
            ),
      appBar: appbarApp(
          context: context,
          title: 'Estimate Request'.tr,
          textWidget: ''.tr,
          onTapLeading: () {}),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                TextBoldeWidget(text: 'Vehicle information'.tr, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextNourmalWidget(
              text: 'Select your vehicle'.tr,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
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

                      navigateTo(context, const AddCarScreen());
                    },
                    icon: const Icon(
                      Icons.car_repair_outlined,
                      size: 30,
                    )),
              ],
            ),
          ),
          Container(
            height: 6,
            color: Colors.grey.withOpacity(0.1),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                TextBoldeWidget(text: 'Estimation expenses'.tr, fontSize: 20),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 6,
            color: Colors.grey.withOpacity(0.1),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextBoldeWidget(text: 'Event data'.tr, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: itemUploadPDFRequest(
              text: pdfText,
              icon: Icons.picture_as_pdf_outlined,
              onPDFSelected: (selectedPDF) {
                setState(() {
                  pdfPath = selectedPDF;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: itemUploadPhotoRequest(
              text: photoText,
              icon: Icons.car_crash_outlined,
              onPhotoSelected: (String? selectedPhoto) {
                setState(() {
                  photoPath = selectedPhoto;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 6,
            color: Colors.grey.withOpacity(0.1),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextBoldeWidget(
                text: 'Choose an estimation date'.tr, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${"Selected Date:".tr} ${selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : "Pick a date"}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    // هنا يمكنك استخدام أي رمز لعرض أن التاريخ تم اختياره
                    const Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          textFieldEstimateRequest()
        ]),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // يمكنك هنا استخدام selectedDate كما تشاء، مثل حفظه في متغير أو استخدامه في وظائف أخرى
      print('${'Selected date:'.tr} $selectedDate');
    }
  }

  Widget textFieldEstimateRequest() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _noteController,
        // استخدم المتحكم لربط الحقل النصي
        maxLines: 5,
        decoration:   InputDecoration(
          labelText: 'Enter a note'.tr,
          fillColor: Colors.white,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
        cursorColor: Colors.black,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
