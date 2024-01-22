import 'package:atlobha/global/utils/image_app.dart';
import 'package:flutter/material.dart';

class LogoAppWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? url;
  const LogoAppWidget({Key? key,   this.width,   this.height, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(

      url?? ImageApp.logoAppImage,
      width: width ?? 120,
      height:height ?? 120,
      fit: BoxFit.fill,
    );
  }
}


