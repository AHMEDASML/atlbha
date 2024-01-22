import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:flutter/material.dart';

class ButtonAppGold extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final TextStyle? style;
  final BoxShadow? boxShadow;
  final void Function()? onTap;

  const ButtonAppGold(
      {Key? key,
      required this.text,
      this.width,
      this.height,
      this.style,
      this.boxShadow,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width ?? SizeApp.screenSize.width / 1.2,
          height: height ?? 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorManager.yellow2,
            boxShadow: [
              boxShadow ??
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 1,
                      offset: Offset(0.0, 0)),
            ],
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: style ??
                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorManager.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
