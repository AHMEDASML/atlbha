import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetPreviousItems extends StatefulWidget {
  const WidgetPreviousItems({Key? key}) : super(key: key);

  @override
  State<WidgetPreviousItems> createState() => _WidgetPreviousItemsState();
}

class _WidgetPreviousItemsState extends State<WidgetPreviousItems> {
  final token=CacheHelper.getData(key: TOKEN);
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
              text: token == null  ? 'You must log in'.tr: 'There are no requests yet'.tr,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
