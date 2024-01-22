 import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';

Widget loadingAppWidget(){
  return Padding(
    padding: EdgeInsets.all(30.0),
    child: Center(child: CircularProgressIndicator(

      color: ColorManager.yellow2,
    )),
  );
}