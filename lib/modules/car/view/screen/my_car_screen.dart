import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/common/loading_app.dart';
import 'package:atlobha/global/components/appbar_app.dart';

import 'package:atlobha/modules/car/controller/car_controller.dart';

import 'package:atlobha/modules/car/view/screen/add_car_screen.dart';
import 'package:atlobha/modules/car/view/widget/itemmy_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCarScreen extends StatefulWidget {
  const MyCarScreen({Key? key}) : super(key: key);

  @override
  State<MyCarScreen> createState() => _MyCarScreenState();
}

class _MyCarScreenState extends State<MyCarScreen> {
  final cont = Get.put(CarController());


  @override
  void initState() {
  cont.getMyCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarApp(
            context: context,
            title: 'My cars'.tr,
            textWidget: 'Add car'.tr,
            onTapLeading: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddCarScreen()),);
              // navigateTo(context, const AddCarScreen());
            }),
        body: GetBuilder<CarController>(
          builder: (con) {
            return con.loading == false
                ? ListView.builder(
                    itemCount: con.myCarsModel!.data.length,
                    itemBuilder: (context, index) {
                      return Column(children: [
                        ItemMyCarWidget(
                          data: con.myCarsModel!.data[index],
                          isVirtual: true,
                          funEdite: () {
                            cont.defaultCar(
                                id: con.myCarsModel!.data[index].id);
                            cont.getMyCars();
                            Navigator.pop(context);
                          },
                          funDelete: () {
                            cont.deleteCar(id: con.myCarsModel!.data[index].id);
                            cont.getMyCars();
                            Navigator.pop(context);
                          },
                        ),
                      ]);
                    })
                : loadingAppWidget();
          },
        ));
  }
}
