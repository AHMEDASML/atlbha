import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

deletionMessage({
  required BuildContext context,required String title,required String titleDesc,required String mess,required void Function()? onPressed}){
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:   Text(titleDesc),
        actions: <Widget>[
          TextButton(
            child:  Text('Cancel'.tr),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed:onPressed,
            child: TextBoldeWidget(text: mess,fontSize: 14,color: ColorManager.yellow2)
          ),
        ],
      );
    },
  );
}