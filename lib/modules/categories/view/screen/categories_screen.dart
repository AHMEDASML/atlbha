import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/basket/controller/basket_controller.dart';
import 'package:atlobha/modules/categories/controller/categories_controller.dart';
import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:atlobha/modules/categories/view/widget/appbar_categories.dart';
import 'package:atlobha/modules/categories/view/widget/grid_view_sub_categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  final int idCategory;
  final String title;

  const CategoriesScreen(
      {Key? key, required this.idCategory, required this.title})
      : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? selectedSubCategory;
  Scat? selectedDatum;
  final cont = Get.put(CategoriesController());
  final contBasket = Get.put(BasketController());

  @override
  void initState() {
    super.initState();
    cont.getCategoriesData(setInitialCategory, widget.idCategory);
  }

  void setInitialCategory(Scat firstCategory) {
    setState(() {
      selectedSubCategory = firstCategory.name;
      selectedDatum = firstCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarCategories(text: widget.title, context: context),
        body: GetBuilder<CategoriesController>(
          init: CategoriesController(),
          builder: (con) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 2),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.white4,
                ),
                child: con.loading == false
                    ? SingleChildScrollView(
                        child: Column(children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: con.categoryModel.value?.data.scat
                                  .map((scatItem) => subCategories(
                                text: scatItem.name,
                                onTap: () => selectSubCategory(scatItem.name),
                              ))
                                  .toList() ??
                                  [],
                            ),
                          ),


                             Row(
                      children: selectedDatum?.branches
                          .map((branch) => subCategories(
                        text: branch.name,
                        onTap: () => selectSubCategory(branch.name),
                      ))
                          .toList() ??
                          [const Text('No branches')]),

                          
                          const SizedBox(
                            height: 30,
                          ),
                          GridViewSubCategories(selectedDatum: selectedDatum),

                        ]),
                      )
                    : loadingAppWidget(),
              ),
            );
          },
        ));
  }

  Widget subCategories({required String text, required VoidCallback onTap}) {
    bool isSelected = selectedSubCategory == text;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 40,
          decoration: BoxDecoration(
              color: isSelected ? const Color(0xffFCF3CA) : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : ColorManager.blueGrey2)),
          child: Center(
              child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: ColorManager.yellow2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
          )),
        ),
      ),
    );
  }

  void selectSubCategory(String category) {
    setState(() {
      if (selectedSubCategory == category) {
        selectedSubCategory = null;
        selectedDatum = null;
      } else {
        selectedSubCategory = category;
        var categoriesData = cont.categoryModel.value?.data;
        if (categoriesData != null) {
          selectedDatum = categoriesData.scat.firstWhere(
                (datum) => datum.name == category,
            orElse: () => Scat(
              id: 0,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              name: '',
              categoryId: 0,
              branches: [],
            ),
          );
        }
      }
    });
  }
}

class ItemSubProduct extends StatefulWidget {
  final Product? product;

  const ItemSubProduct({Key? key, this.product}) : super(key: key);

  @override
  State<ItemSubProduct> createState() => _ItemSubProductState();
}

class _ItemSubProductState extends State<ItemSubProduct> {
  int count = 0;
  BasketController basketController = Get.find<BasketController>();
  double elevationItem = 0.0;
  Color color = Colors.transparent;

  void _incrementCount() {
    if (widget.product != null) {
      // Null check
      setState(() {
        count++;
        basketController.addProduct(
            widget.product!, count); // Non-nullable assertion
        if (count >= 0) {
          elevationItem = 1;
          color = Colors.white;
        }
      });
    }
  }

  void _discrementCount() {
    if (widget.product != null && count > 0) {
      // Null check and ensure count is positive
      setState(() {
        count--;
        basketController.addProduct(
            widget.product!, count); // Non-nullable assertion
        if (count <= 0) {
          elevationItem = 0.0;
          color = Colors.transparent;
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int count = 0;

    return Container(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            // width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/250?image=9'),
                // Replace with your image URLs
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: elevationItem,
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (count > 0 && count != 0)
                    GestureDetector(
                      onTap: _discrementCount,
                      child: iconAppCategories(icon: Icons.remove),
                    ),
                  const SizedBox(width: 10),
                  if (count > 0 && count != 0) Text(count.toString()),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _incrementCount,
                    child: iconAppCategories(icon: Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),
        Text(
          widget.product?.name ?? 'name category'.tr,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: ColorManager.black,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        )
      ]),
    );
  }
}

Widget iconAppCategories({required IconData icon}) {
  return Container(
    decoration: BoxDecoration(
        color: ColorManager.yellow2, borderRadius: BorderRadius.circular(50)),
    child: Icon(icon),
  );
}
