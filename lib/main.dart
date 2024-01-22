import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/localization/locale.dart';
import 'package:atlobha/global/localization/locale_controller.dart';
import 'package:atlobha/global/utils/bindings_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/account_type/view/screen/account_type_screen.dart';
import 'package:atlobha/modules/account/banana_account/view/screen/login_banana_account.dart';
import 'package:atlobha/modules/account/banana_account/view/screen/reg_banana_account.dart';
import 'package:atlobha/modules/account/company_account/view/screen/login_company_account.dart';
import 'package:atlobha/modules/account/company_account/view/screen/reg_company_account.dart';
import 'package:atlobha/modules/account/user_account/view/screen/login_user_account.dart';
import 'package:atlobha/modules/account/user_account/view/screen/reg_user_account.dart';
import 'package:atlobha/modules/car/view/screen/add_car_screen.dart';
import 'package:atlobha/modules/car/view/screen/my_car_screen.dart';
import 'package:atlobha/modules/categories/view/screen/categories_screen.dart';
import 'package:atlobha/modules/categories/view/screen/details_sub_product.dart';
import 'package:atlobha/modules/estimate_request/view/estimate_request_screen.dart';
import 'package:atlobha/modules/home/view/screen/spare_parts_requests.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:atlobha/modules/splash/view/screen/select_language.dart';
import 'package:atlobha/modules/splash/view/screen/splash_screen.dart';
import 'package:atlobha/modules/test_delet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'global/data/local/cache_helper.dart';
import 'global/utils/key_shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 50));
  SizeApp.screenSize =
      MediaQueryData.fromView(WidgetsBinding.instance.window).size;
  DioHelper.init();
  await CacheHelper.init();

  Widget initialScreen;

  // Check if TOKEN is null
  if (CacheHelper.getData(key: IfHeComesIn) == null) {
    initialScreen = SplashScreen();
  } else {

    initialScreen = CacheHelper.getData(key: TOKEN) == null
        ? LayoutScreen()
        : LayoutScreen();

    // initialScreen = CacheHelper.getData(key: TOKEN) == null
    //     ? LayoutScreen()
    //     : LayoutScreen();
  }

  runApp(MyApp(initialScreen: initialScreen));
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;

  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: language(),
      translations: LocaleApp(),
      initialBinding: BindingsApp(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      home: initialScreen,
    );
  }
}

