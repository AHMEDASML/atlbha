import 'dart:convert';

import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/account/user_account/model/createusers_model.dart';
import 'package:atlobha/modules/account/user_account/model/login_users_model.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  bool loading = false;
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginUsersModel? createUsersModel;

  Future<void> loginUser({
    required BuildContext context,
  }) async {
    setLoading(true);

    final data = json.encode({
      'phone': numberController.text.trim(),
      'password': passwordController.text.trim(),

    });

    try {
      setLoading(true);
      var response = await DioHelper.postData(url: loginUrl, data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        createUsersModel = LoginUsersModel.fromJson(response.data);

        // print(createUsersModel!.data.id);
        print(createUsersModel!.data.phone);
        CacheHelper.saveData(key: TOKEN, value: createUsersModel!.token);
        await CacheHelper.saveData(
            key: NAMEUSER, value: createUsersModel!.data.username);
        await CacheHelper.saveData(
            key: NUMBERUSER, value: createUsersModel!.data.phone);

        setLoading(false);
        navigateAndFinish(context, const LayoutScreen());
      } else {
        setLoading(false);
      }
    } catch (e) {
      showToastApp(text: 'Try again', color: ColorManager.firstRed);
      print(e.toString());
      setLoading(false);
    }
  }



  // Future<void> loginUser({required BuildContext context}) async {
  //   try {
  //     final data = json.encode({
  //       'username': nameController.text,
  //       'password': passwordController.text,
  //       'profile_img': 'sda',
  //       'role_name': 'customer',
  //       'phone': numberController.text,
  //       'password_confirmation': passwordController.text,
  //     });
  //
  //     setLoading(true);
  //
  //     var dio = Dio();
  //     var response = await dio.request(
  //       registerUserUrl,
  //       options: Options(
  //         method: 'POST',
  //       ),
  //       data: data,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print(json.encode(response.data));
  //
  //       createUsersModel = CreateUsersModel.fromJson(response.data);
  //
  //       CacheHelper.saveData(key: TOKEN, value: createUsersModel!.token);
  //       await CacheHelper.saveData(
  //           key: NAMEUSER, value: createUsersModel!.data.username);
  //       await CacheHelper.saveData(
  //           key: NUMBERUSER, value: createUsersModel!.data.phone);
  //
  //       setLoading(false);
  //       navigateAndFinish(context, LayoutScreen());
  //     } else {
  //       print(response.statusMessage);
  //       setLoading(false);
  //     }
  //   } catch (e) {
  //     setLoading(false);
  //     print(e.toString());
  //     showToastApp(text: 'Try again', color: ColorManager.firstRed);
  //   }
  // }
  void setLoading(bool status) {
    loading = status;
    update();
  }
}
