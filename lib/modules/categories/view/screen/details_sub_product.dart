import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/basket/controller/basket_controller.dart';
import 'package:atlobha/modules/categories/controller/categories_controller.dart';
import 'package:atlobha/modules/categories/models/category_model.dart';
import 'package:atlobha/modules/categories/view/widget/card_sub_product.dart';
import 'package:atlobha/modules/categories/view/widget/item_one_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../global/common/loading_app.dart';
import '../../models/details_sub_product_model.dart';

class DetailsSubProduct extends StatefulWidget {
  final int idCategory;

  const DetailsSubProduct({Key? key, required this.idCategory})
      : super(key: key);

  @override
  State<DetailsSubProduct> createState() => _DetailsSubProductState();
}

class _DetailsSubProductState extends State<DetailsSubProduct> {
  final cont = Get.put(CategoriesController());
  final basketController = Get.put(BasketController());

  @override
  void initState() {
    print(widget.idCategory);
    cont.getDetailsProductData(idCategory: widget.idCategory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        // bottomNavigationBar: GetBuilder<CategoriesController>(
        //   builder: (con) {
        //     if (con.detailsSubProductModel != null) {
        //       Product product =
        //           con.detailsSubProductModel.value!.data.toProduct();
        //       return CardSubProduct(
        //         product: product,
        //         basketController: basketController,
        //       );
        //     } else {
        //       return const SizedBox
        //           .shrink(); // Return an empty widget if data isn't loaded
        //     }
        //   },
        // ),
        body: GetBuilder<CategoriesController>(
          builder: (con) {
            return con.loading == false
                ? SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBoldeWidget(
                            text: con.detailsSubProductModel.value!.data.name,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          // width: 50,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                  con.detailsSubProductModel.value!.data.image),
                              // Replace with your image URLs
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: ColorManager.grayApp,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: TextBoldeWidget(
                                        text: 'the type of car'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  itemOneDetails(
                                    urlNetworkImage: con.detailsSubProductModel
                                        .value!.data.logo,
                                    type: con.detailsSubProductModel.value!.data
                                        .type,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TextBoldeWidget(
                                        text: 'reference number'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        color: ColorManager.white,
                                      ),
                                      child: GestureDetector(
                                        onTap: _copyReferralCode,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              TextBoldeWidget(
                                                  text:
                                                      "#${con.detailsSubProductModel.value!.data.subCatId.toString()}",
                                                  fontSize: 14,
                                                  color: ColorManager.gray6,
                                                  textAlign: TextAlign.end,
                                                  fontWeight: FontWeight.w500),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Icon(Icons.copy_outlined),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: TextBoldeWidget(
                                        text: 'Details of the piece'.tr,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  TextBoldeWidget(
                                      text: con.detailsSubProductModel.value!
                                          .data.details,
                                      fontSize: 14,
                                      textAlign: TextAlign.start,
                                      color: ColorManager.gray6,
                                      fontWeight: FontWeight.w300),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ))
                : loadingAppWidget();
          },
        ));
  }

  void _copyReferralCode() {
    Clipboard.setData(ClipboardData(
            text: cont.detailsSubProductModel.value!.data.subCatId.toString()))
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Referral code copied to clipboard")),
      );
    });
  }
}

// extension DataToProduct on Data {
//   Product toProduct() {
//     return Product(
//       id: this.id,
//       createdAt: this.createdAt,
//       updatedAt: this.updatedAt,
//       name: this.name,
//       image: this.image,
//       price: this.price,
//       logo: this.logo,
//       type: this.type,
//       symbol: this.symbol,
//       details: this.details,
//       hiddenPrice: this.hiddenPrice,
//       quantity: this.quantity,
//       subCatId: this.subCatId,
//       status: this.status,
//       isList: this.isList,
//       branchId: this.branchId,
//     );
//   }
// }
