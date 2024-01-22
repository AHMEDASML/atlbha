import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget sparePart({required BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorManager.red2,
                ColorManager.white5,
              ])),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            ImageApp.logoAppImage,
            height: 60,
            width: 60,
            fit: BoxFit.fill,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            height: 100,
            width: 160,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBoldeWidget(
                  fontWeight: FontWeight.w500,
                  text: 'Spare parts requests'.tr,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextNourmalWidget(
                      text:
                          'You can specify the required piece and raise its price for free'
                              .tr,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        ButtonAppGold(
          text: 'Order now!'.tr,
          height: 40,
          width: 90,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.grey6,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
        )
      ]),
    ),
  );
}
