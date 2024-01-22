import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

Widget noTokenWelcome() {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextBoldeWidget(
          fontWeight: FontWeight.w500,
          text: 'Welcome, visitor'.tr,
          fontSize: 20,
          textAlign: TextAlign.start),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextNourmalWidget(text: 'How can we help you?'.tr, fontSize: 16),
    ),
  ]);
}

Widget yesTokenWelcome({required String text1,required String text2}) {

  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextBoldeWidget(
          fontWeight: FontWeight.w500,
          text: text1,
          fontSize: 20,
          textAlign: TextAlign.start),
    ),
    const SizedBox(
      height: 10,
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextNourmalWidget(text: text2, fontSize: 16),
    ),
  ]);
}
