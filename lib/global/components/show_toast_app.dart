import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastApp({required String text ,Color? color}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:color ??  ColorManager.secondBlue,
      textColor:ColorManager.white,
      fontSize: 16.0
  );
}