import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:atlobha/modules/categories/models/details_sub_product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:atlobha/global/data/remote/dio_helper.dart';
import 'package:atlobha/global/endpoints/url_api.dart';

class CategoriesController extends GetxController {
  Rxn<CategoryModel> categoryModel = Rxn<CategoryModel>();
  Rxn<DetailsSubProductModel> detailsSubProductModel =
      Rxn<DetailsSubProductModel>();
  var loading = false.obs;

  Future<void> getCategoriesData(
      Function(Scat) onFirstCategoryFetched, int idCategory) async {
    loading(true);
    try {
      var response = await DioHelper.getData(url: '$categoryUrl$idCategory');
      if (response.statusCode == 200 && response.data != null) {
        categoryModel.value = CategoryModel.fromJson(response.data);
        var categoryData = categoryModel.value?.data;
        if (categoryData != null && categoryData.scat.isNotEmpty) {
          onFirstCategoryFetched(categoryData.scat.first);
        }
      } else {
        print('Failed to load data: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      loading(false);
    }
  }

  @override
  void onInit() {
    // getCategoriesData();
    super.onInit();
  }

  Future<void> getDetailsProductData({required int idCategory}) async {
    loading(true);
    try {
      var response =
          await DioHelper.getData(url: '$detailsProductUrl$idCategory');
      if (response.statusCode == 200 && response.data != null) {
        detailsSubProductModel.value =
            DetailsSubProductModel.fromJson(response.data);
      } else {
        print('Failed to load data: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      loading(false);
    }
  }

  void setLoading(RxBool status) {
    loading = status;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update();
    });
  }
}
