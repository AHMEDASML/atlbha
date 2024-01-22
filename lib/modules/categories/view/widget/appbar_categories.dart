import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:flutter/material.dart';

appbarCategories({required String text, required BuildContext context}) {
  return AppBar(
    elevation: 2.0,
    shadowColor: ColorManager.secondGray.withOpacity(0.6),

    leading: IconButton(
      icon: Icon(Icons.search, color: ColorManager.gray6, size: 30),
      onPressed: () {
        // Handle the search action
      },
    ),
    title: Text(
      text,
      style: TextStyle(
        // Assuming the text is right-to-left, apply the appropriate styling
        fontFamily: 'YourFontFamily', // Replace with your font family
        fontSize: 24,
        color: ColorManager.yellow2, // Adjust the color to match the design
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: Icon(Icons.shopping_cart_outlined,
            color: ColorManager.black, size: 30),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LayoutScreen(
                      index: 2,
                    )),
          );
        },
      ),
    ],
    backgroundColor: ColorManager.white, // Set the AppBar background color
  );
}
