import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextBoldeWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;

  const TextBoldeWidget(
      {Key? key,
      required this.text,
      this.color,
      this.fontSize,
      this.textAlign,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign ?? TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: color ?? ColorManager.black,
              fontSize: fontSize ?? 40,
              fontWeight: fontWeight ?? FontWeight.w700,
            ));
  }
}
