import 'package:atlobha/global/utils/color_app.dart';
import 'package:flutter/material.dart';

class ItemHomeGradient extends StatelessWidget {
  final VoidCallback? onTap;
  final String textTitle;
  final String logo;
  const ItemHomeGradient({Key? key, this.onTap, required this.textTitle, required this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: ColorManager.white, width: 1),
        ),
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            // color: ColorManager.yellow2, // Golden yellow color
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
                color: ColorManager.yellow2,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Text(
                      textAlign: TextAlign.center,
                    textTitle,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    'https://picsum.photos/250?image=9',
                    // Replace with your image URL
                    height: 50,
                    width: 50,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}