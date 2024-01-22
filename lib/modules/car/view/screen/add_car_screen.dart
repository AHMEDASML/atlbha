import 'package:atlobha/global/common/loading_app.dart';
import 'package:atlobha/global/components/appbar_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/car/controller/car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({Key? key}) : super(key: key);

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final cont = Get.put(CarController());
  final TextEditingController numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarApp(context: context, title: 'Add Cars'.tr),
        body: GetBuilder<CarController>(
          init: CarController(),
          builder: (con) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextNourmalWidget(
                          text: 'Manufacturer company'.tr,
                          color: ColorManager.black,
                          fontSize: 18),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CarDropdownMenuApp(
                          carData: cont.nameProduct,
                          onSelected: (value) {
                            cont.setSelectedCompany(value);
                            setState(() {
                              cont.selectedCompany = value; // Update the selected company in the state
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextNourmalWidget(
                                      text: 'Model'.tr,
                                      color: ColorManager.black,
                                      fontSize: 18),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CarDropdownMenuApp(
                                      carData: con.currentModels,
                                      onSelected: (value) {
                                        setState(() {

                                          con.setSelectedModel(value);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextNourmalWidget(
                                      text: 'Manufacturing year'.tr,
                                      color: ColorManager.black,
                                      fontSize: 18),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CarDropdownMenuApp(
                                      carData: con.currentDates,
                                      onSelected: (value) {
                                        setState(() {
                                          con.setSelectedYear(value);


                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextNourmalWidget(
                          text: 'Chassis number'.tr,
                          color: ColorManager.black,
                          fontSize: 18),
                      TextFiledApp(
                        validator: (value) {
                          // Add validator
                          if (value == null || value.isEmpty) {
                            return 'Please enter chassis number'.tr;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        controller: numberController,
                        textTitle: '',
                        hintText: 'Chassis number'.tr,
                        icon: Icons.car_repair,
                      ),
                      con.loading == false
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: ButtonAppGold(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    con.addCar(
                                      context: context,
                                      company: con.selectedCompany,
                                      model: con.selectedModel,
                                      year: con.selectedYear,
                                      number: int.parse(numberController.text),

                                    );
                                  } else {
                                    showToastApp(
                                        text: 'Chassis number must be filled'.tr,
                                        color: ColorManager.firstRed);
                                  }
                                },
                                text: 'addition'.tr,
                              ),
                            )
                          : loadingAppWidget(),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}

class CarDropdownMenuApp extends StatefulWidget {
  final List<String> carData;
  final Function(String) onSelected;

  const CarDropdownMenuApp(
      {Key? key, required this.carData, required this.onSelected})
      : super(key: key);

  @override
  State<CarDropdownMenuApp> createState() => _CarDropdownMenuAppState();
}

class _CarDropdownMenuAppState extends State<CarDropdownMenuApp> {

  @override
  void initState() {
    super.initState();
    if (widget.carData.isNotEmpty) {
      selectedCar = widget.carData.first;
    }

  }

  @override
  void didUpdateWidget(covariant CarDropdownMenuApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    // تأكد من أن القيمة المختارة موجودة في carData
    if (widget.carData.isNotEmpty && !widget.carData.contains(selectedCar)) {
      setState(() {
        selectedCar = widget.carData.first;
      });
    }
  }

  String? selectedCar;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 0.6, color: Colors.black.withOpacity(0.4)),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: selectedCar,
        icon:
            Icon(size: 30, Icons.arrow_drop_down, color: ColorManager.yellow2),
        onChanged: (newValue) {
          setState(() {
            selectedCar = newValue;
          });
          widget.onSelected(newValue!);
        },
        items: widget.carData.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Row(
              children: [
                // Example icon
                const SizedBox(width: 8),
                Text(value,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: ColorManager.black.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}


