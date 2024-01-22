import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextAuth extends StatelessWidget {
  final String textOne;
  final String textTow;
 final  void Function()? onTapTextTow;

  const TextAuth({Key? key, required this.textOne, required this.textTow, this.onTapTextTow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: textOne,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: ColorManager.black),
        children: [
          const TextSpan(
            text: '  ',
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: onTapTextTow,
              child: Text(
                textTow,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorManager.yellow2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
