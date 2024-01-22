import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:flutter/material.dart';

class ButtonAppDark extends StatelessWidget {
  final String  text;
  final Color? color;
  final void Function()? onTap;
  const ButtonAppDark({Key? key, required this.text, this.color, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16,right: 5,left: 5),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: SizeApp.screenSize.width/1.2,
            height: 60,
            decoration: BoxDecoration(
              color: ColorManager.black3,
              borderRadius: BorderRadius.circular(10)
            ),

            child: Center(
              child: Text(text,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: color ?? ColorManager.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,

                  )),
            ),
          ),
        ),
      ),
    );
  }
}
