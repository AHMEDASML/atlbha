import 'dart:convert';

import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/message_error_widget.dart';
import 'package:atlobha/global/components/show_toast_app.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/basket/controller/basket_controller.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:atlobha/modules/my_orders/view/widget/screen_before_logging_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../global/common/loading_app.dart';
import '../../../../global/endpoints/url_api.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  BasketController basketController = Get.find<BasketController>();
  final token = CacheHelper.getData(key: TOKEN);

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> sendRequestCart(List<BasketItem> basketItems) async {
      setState(() {
        isLoading = true;
      });

      const baseUrl = requestCart;

      final token = CacheHelper.getData(key: TOKEN);

      final url = Uri.parse(baseUrl);

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      // تحويل قائمة المنتجات إلى قائمة من Map
      final List<Map<String, dynamic>> productsList =
          basketItems.map((basketItem) {
        return {
          "product_id": basketItem.product.id,
          "quantity": basketItem.product.quantity,
        };
      }).toList();

      final body = jsonEncode({
        "products_ids": productsList,
      });

      try {
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );

        setState(() {
          isLoading = false;
        });

        if (response.statusCode == 200) {
          print("Success: ${response.body}");
          showToastApp(text: "تم إرسال الطلب بنجاح", color: Colors.green);
          basketController.clean();
        } else {
          print("Error: ${response.statusCode}, ${response.body}");
          showToastApp(text: "Error: ${response.statusCode}, ${response.body}");
        }
      } catch (error) {
        print("Error: $error");
        showToastApp(text: "Error: $error");
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: TextBoldeWidget(text: 'The basket'.tr, fontSize: 20),
      ),
      bottomNavigationBar: basketController.products.isNotEmpty
          ? Container(
              height: 80,
              decoration: BoxDecoration(
                color: ColorManager.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      blurRadius: 10.0,
                      spreadRadius: 1,
                      offset: const Offset(0.0, 0)),
                ],
              ),
              child: isLoading
                  ? loadingAppWidget()
                  : ButtonAppGold(
                      onTap: () {
                        if (token == null) {
                          showFlashError(
                              context: context,
                              message: 'يجب تسجيل الدخول اولا ');
                        } else {
                          // جلب جميع المنتجات في السلة
                          Map<int, BasketItem> allProductsInBasket =
                              basketController.products;

                          basketController.products.forEach((key, basketItem) {
                            // print('عدد المنتجات في السلة: ${value.quantity}');
                            // print('عدد المنتجات في السلة: ${value.product.quantity}');
                            sendRequestCart(
                                basketController.products.values.toList());
                          });
                          Get.to(const LayoutScreen());
                          // يمكنك استخدام allProductsInBasket كما تحتاج هنا
                        }
                      },
                      height: 50,
                      text: 'Complete the application'.tr,
                    ),
            )
          : Container(width: 1, height: 1),
      body: GetBuilder<BasketController>(
        builder: (controller) {
          if (controller.products.isEmpty) {
            return ScreenBeforeLoggingInWidget(
                text: 'There are no products in the cart'.tr);
          } else {
            return ListView.builder(
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final basketItem = controller.products.values.elementAt(index);
                final product = basketItem.product;
                final quantity = basketItem.quantity;

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    child: ListTile(
                      leading: Image.network(product.image, fit: BoxFit.fill),
                      title: Column(
                        children: [
                          const SizedBox(height: 10),
                          TextBoldeWidget(
                              text: product.name,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1.2,
                                    color: Colors.black.withOpacity(0.4)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'quantity'.tr,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove,
                                        color: ColorManager.yellow2),
                                    onPressed: () => basketController
                                        .decrementProductCount(product.id),
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add,
                                        color: ColorManager.yellow2),
                                    onPressed: () => basketController
                                        .incrementProductCount(product.id),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete,
                                        color: ColorManager.black
                                            .withOpacity(0.8)),
                                    onPressed: () => basketController
                                        .removeProduct(product.id),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
