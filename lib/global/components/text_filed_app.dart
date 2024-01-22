import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';

class TextFiledApp extends StatelessWidget {
  final String textTitle;
  final IconData? icon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Added validator parameter

  const TextFiledApp(
      {Key? key,
      required this.textTitle,
      this.icon,
      this.hintText,
      this.keyboardType,
      this.controller,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textTitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: ColorManager.fourthHeavenly,
          style: TextStyle(color: ColorManager.gray2, fontSize: 16),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.2, color: ColorManager.black.withOpacity(0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorManager.firstBlack.withOpacity(0.5)),
            ),
            filled: true,
            fillColor: Colors.transparent,
            hintText: hintText ?? "",
            hintStyle: TextStyle(
              color: ColorManager.gray1,
              fontSize: 16,
            ),

            prefixIcon: Icon(icon, color: ColorManager.black.withOpacity(0.7)),
            // suffixIcon: Icon(Icons.abc) ,
          ),
          validator: validator,
        ),
      ],
    );
  }
}
