 import 'package:atlobha/modules/my_orders/model/my_orders_model.dart';
import 'package:get/get.dart';

import 'dart:convert';

import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/account/user_account/model/createusers_model.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersController extends GetxController {
  var loading = false.obs;
  final token = CacheHelper.getData(key: TOKEN);
  MyOrdersModel? myOrdersModel;

  Future<void> getMyOrders({required BuildContext context}) async {
    try {
      setLoading(true);

      // var headers = {'Authorization': 'Bearer $token'};

      var headers = {
        'Authorization':
            'Bearer $token'
      };

      var dio = Dio();

      var response = await dio.request(
        myRequestsUrl,
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        myOrdersModel = MyOrdersModel.fromJson(response.data);

        setLoading(false);
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
    loading = status.obs;
    update();
  }
}
