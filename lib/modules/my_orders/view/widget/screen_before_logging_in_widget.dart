import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenBeforeLoggingInWidget extends StatelessWidget {
  final String? text;

  const ScreenBeforeLoggingInWidget({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.asset(
            ImageApp.beforeLoggingIn,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Center(
          child: TextBoldeWidget(
              text: text ?? 'You must log in'.tr,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
