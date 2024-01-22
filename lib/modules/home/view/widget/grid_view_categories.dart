import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/modules/categories/view/screen/categories_screen.dart';
import 'package:atlobha/modules/home/models/home_model.dart';
import 'package:atlobha/modules/home/view/screen/home_screen.dart';
import 'package:atlobha/modules/home/view/widget/item_home_gradient.dart';
import 'package:flutter/material.dart';

class GridViewCategories extends StatelessWidget {
  final List<Category> categories;
  final int? item;

  const GridViewCategories({Key? key, required this.categories, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = item != null ? item! + 1 : categories.length + 1;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        // Check if the current item is the "More" item
        if (index == itemCount - 1) {
          return ItemHomeGradient(
            textTitle: 'More',
            logo: 'path_to_more_icon',
            onTap: () {
              bottomSheetCategories(context: context, categories: categories);
            },
          );
        } else {
          return ItemHomeGradient(
            textTitle: categories[index].name,
            logo: categories[index].logo,
            onTap: () {
              navigateTo(
                  context,
                  CategoriesScreen(
                    title: categories[index].name,
                    idCategory: categories[index].id,
                  ));
            },
          );
        }
      },
    );
  }
}
