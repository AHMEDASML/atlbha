import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/basket/controller/basket_controller.dart';
import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardSubProduct extends StatefulWidget {
  final Product product; // Add Product to the widget
  final BasketController basketController; // Add BasketController to the widget
  const CardSubProduct({Key? key, required this.product, required this.basketController}) : super(key: key);

  @override
  State<CardSubProduct> createState() => _CardSubProductState();
}

class _CardSubProductState extends State<CardSubProduct> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.white, boxShadow: const [
        BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            spreadRadius: 1,
            offset: Offset(0.0, 1)),
      ]),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                });
              },
              icon: Icon(
                Icons.add,
                color: ColorManager.yellow2,
                size: 30,
              ),
            ),
            Text(
              '$count',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            IconButton(
              onPressed: () {
                if (count == 0) {
                } else {
                  count--;
                }
              },
              icon: Icon(
                Icons.remove,
                color: ColorManager.yellow2,
                size: 30,
              ),
            ),
            ButtonAppGold(
              onTap: (){
                if (count > 0) {

                  widget.basketController.addProduct(widget.product, count);
                  setState(() {
                    count=0;
                  });
                }
              },
              text: 'add to cart'.tr,
              width: 150,
              height: 40,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: ColorManager.gray2,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
