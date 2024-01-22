import 'dart:convert';

import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/account/company_account/model/user_cop_model.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserCompanyController extends GetxController {
  bool loading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameCompanyController = TextEditingController();
  TextEditingController locationCompanyController = TextEditingController();
  UserCompModel? userCompModel;

  Future<void> registrationComp({required BuildContext context}) async {
    try {
      final data = json.encode({
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim(),
        'profile_img': 'sda',
        'role_name': 'company',
        'phone': phoneController.text.trim(),
        'name_company': nameCompanyController.text.trim(),
        'password_confirmation': passwordController.text.trim(),
        'location_company': locationCompanyController.text.trim()

        // 'username': 'company_test',
        // 'password': '12345678',
        // 'profile_img': 'sda',
        // 'role_name': 'company',
        // 'phone': '0985896985',
        // 'password_confirmation': '12345678',
        // 'name_company': 'fgchvuj',
        // 'location_company': 'jknkjknkn'
      });

      setLoading(true);

      var dio = Dio();
      var response = await dio.request(
        registerCompanyUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        print(json.encode(response.data));
        userCompModel = UserCompModel.fromJson(response.data);
        CacheHelper.saveData(key: TOKEN, value: userCompModel!.token);
        await CacheHelper.saveData(
            key: NAMEUSER, value: userCompModel!.data.username);
        await CacheHelper.saveData(
            key: NUMBERUSER, value: userCompModel!.data.phone);

        setLoading(false);
        navigateAndFinish(context, LayoutScreen());
      } else {
        print(response.statusMessage);
        setLoading(false);
      }
    } catch (e) {
      setLoading(false);
      print(e.toString());
      showToastApp(text: 'Try again', color: ColorManager.firstRed);
    }
  }

  void setLoading(bool status) {
    loading = status;
    update();
  }
}
