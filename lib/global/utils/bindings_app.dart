import 'package:atlobha/modules/basket/controller/basket_controller.dart';
import 'package:atlobha/modules/car/controller/car_controller.dart';
import 'package:atlobha/modules/categories/controller/categories_controller.dart';
import 'package:atlobha/modules/home/controller/home_controller.dart';
import 'package:get/get.dart';


class BindingsApp implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => BasketController(),fenix: true);
    Get.lazyPut(() => HomeController(),fenix: true);
    Get.lazyPut(() => CategoriesController(),fenix: true);
    // Get.lazyPut(() => CarController(),fenix: true);



  }
}