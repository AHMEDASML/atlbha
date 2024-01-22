import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:atlobha/modules/categories/view/screen/categories_screen.dart';
import 'package:atlobha/modules/categories/view/screen/details_sub_product.dart';
import 'package:flutter/material.dart';

import '../../../../global/common/functions_app.dart';

class GridViewSubCategories extends StatelessWidget {
  final Datum? selectedDatum;
  const GridViewSubCategories({Key? key, this.selectedDatum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: selectedDatum?.products.length ?? 0,
      itemBuilder: (context, index) {
        final product = selectedDatum?.products[index];
        return GestureDetector(
          onTap: () {
            navigateTo(
                context,
                DetailsSubProduct(
                  idCategory: product!.id,
                ));
          },
          child: ItemSubProduct(
            key: ValueKey<int>(product?.id ?? 0),
            // تأكد من أن id هو فريد لكل منتج
            product: product,
          ),
        );
      },
    );
  }
}
