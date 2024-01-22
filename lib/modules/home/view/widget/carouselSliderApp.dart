import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/modules/categories/view/screen/details_sub_product.dart';
import 'package:atlobha/modules/home/models/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderAdsApp extends StatelessWidget {
  final List<Ad> ads;
  final double? height;

  const CarouselSliderAdsApp({Key? key, this.height, required this.ads})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height ?? 150.0,
        enlargeCenterPage: true,
      ),
      items: List.generate(ads.length, (index) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(

              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  image:   DecorationImage(
                    image: NetworkImage(ads[index].image.toString()),
                    // Replace with your image URLs
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}



class CarouselSliderApp extends StatelessWidget {
  final List<SuggestionProduct> suggestionProducts;
  final double? height;

  const CarouselSliderApp({Key? key, this.height, required this.suggestionProducts,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: height ?? 150.0,
        enlargeCenterPage: true,
      ),
      items: List.generate(suggestionProducts.length, (index) {
        return GestureDetector(
          onTap: (){
            navigateTo(context,DetailsSubProduct(idCategory: suggestionProducts[index].id,));
          },
          child: Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.white,
                  image:   DecorationImage(
                    image: NetworkImage(suggestionProducts[index].image),
                    // Replace with your image URLs
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
