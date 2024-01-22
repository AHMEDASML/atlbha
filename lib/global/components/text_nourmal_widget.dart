import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextNourmalWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;

  const TextNourmalWidget(
      {Key? key, required this.text, this.color, this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color ?? ColorManager.black4,
              fontSize: fontSize ?? 20,
              fontWeight: FontWeight.w400,
            ));
  }
}
