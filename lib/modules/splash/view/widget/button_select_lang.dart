import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonSelectLang extends StatelessWidget {
  const ButtonSelectLang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorManager.secondBlue),
        child: Center(
          child: Text(
            'Select'.tr,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w200,
                fontSize: 16,
                color: ColorManager.white),
          ),
        ),
      ),
    );
  }
}
