import 'package:atlobha/global/utils/color_app.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appbarApp({required BuildContext context,required String title,Widget? widget ,
  String? textWidget,void Function()? onTapLeading}){
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    backgroundColor: ColorManager.white,
    title: Text(title,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      color:  ColorManager.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,

    )),

    actions: [

      GestureDetector(
        onTap: onTapLeading?? (){},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: widget ?? Center(
            child: Text(textWidget ?? ''.tr,style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color:   ColorManager.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,

            )),
          ),
        ),
      ),
    ],

  );
}