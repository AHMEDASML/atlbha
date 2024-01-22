import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget itemOneDetails({required String type,required String urlNetworkImage,}) {
  return Container(
    decoration: BoxDecoration(
        color: ColorManager.white, borderRadius: BorderRadius.circular(16)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 65,
          height: 65,
          decoration:   BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage(urlNetworkImage),
              // Replace with your image URLs
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          height: 70,
          width: 0.3,
          color: ColorManager.black.withOpacity(0.5),
        ),
      ),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextBoldeWidget(
                text: type, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextBoldeWidget(
                text: 'All '.tr, fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextBoldeWidget(
              text: '2024 - 1980', fontSize: 12, fontWeight: FontWeight.w200),
          SizedBox(
            height: 10,
          ),
          Text('')
        ],
      ),
    ]),
  );
}