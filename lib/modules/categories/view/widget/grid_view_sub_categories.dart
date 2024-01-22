import 'package:atlobha/modules/categories/view/screen/details_sub_product.dart';
import 'package:flutter/material.dart';

import '../../../../global/common/functions_app.dart';
import '../../models/category_model.dart';

class GridViewSubCategories extends StatelessWidget {
  final List<Product>? products;

  const GridViewSubCategories({Key? key, this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (products == null) {
      return Center(child: Text("No products available"));
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 2,
        childAspectRatio: 0.8,
      ),
      itemCount: products!.length, // Safe to use ! since we checked for null
      itemBuilder: (context, index) {
        final product = products![index]; // Safe to use ! since we checked for null
        return GestureDetector(
          onTap: () {
            navigateTo(
                context,
                DetailsSubProduct(
                  idCategory: product.id,
                ));
          },
          child: Container(
            // Implement your product display here
            child: Text(product.name),
          ),
        );
      },
    );
  }
}
