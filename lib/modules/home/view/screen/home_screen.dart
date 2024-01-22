import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/estimate_request/view/estimate_request_screen.dart';
import 'package:atlobha/modules/home/controller/home_controller.dart';
import 'package:atlobha/modules/home/models/home_model.dart';
import 'package:atlobha/modules/home/view/screen/spare_parts_requests.dart';
import 'package:atlobha/modules/home/view/widget/carouselSliderApp.dart';
import 'package:atlobha/modules/home/view/widget/floating_action_app_whatsApp.dart';
import 'package:atlobha/modules/home/view/widget/grid_view_categories.dart';
import 'package:atlobha/modules/home/view/widget/item_home_gradient.dart';
import 'package:atlobha/modules/home/view/widget/item_home_welcom.dart';
import 'package:atlobha/modules/home/view/widget/spare_part_wudget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cont = Get.put(HomeController());
  final token = CacheHelper.getData(key: TOKEN);
  final name = CacheHelper.getData(key: NAMEUSER);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: floatingActionAppWhatsApp(),
        body: GetBuilder<HomeController>(
          builder: (con) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: con.loading == false
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            const SizedBox(
                              height: 5,
                            ),
                            token == null
                                ? noTokenWelcome()
                                : yesTokenWelcome(
                                    text1: '$name' '${" : Hey, you".tr}',
                                    text2: 'How can I help you now ?'.tr),
                            const SizedBox(
                              height: 10,
                            ),
                            CarouselSliderAdsApp(
                              ads: con.homeModel!.data.ads,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextBoldeWidget(
                                fontWeight: FontWeight.w600,
                                text: 'Our chosen products'.tr,
                                fontSize: 18,
                                textAlign: TextAlign.start),
                            const SizedBox(
                              height: 20,
                            ),
                            CarouselSliderApp(
                              height: 120,
                              suggestionProducts:
                                  con.homeModel!.data.suggestionProducts,
                            ),

                            const SizedBox(
                              height: 20,
                            ),
                            TextBoldeWidget(
                                fontWeight: FontWeight.w600,
                                text: 'Discover and order'.tr,
                                fontSize: 18,
                                textAlign: TextAlign.start),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  navigateTo(
                                      context, const SparePartsRequests());
                                },
                                child: sparePart(context: context)),
                            GridViewCategories(
                                categories: con.homeModel!.data.categories,
                                 ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: TextBoldeWidget(
                                  fontWeight: FontWeight.w400,
                                  text: 'Request an estimate'.tr,
                                  fontSize: 16,
                                  textAlign: TextAlign.start),
                            ),
                             Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 10),
                              child: GestureDetector(
                                onTap: (){
                                  navigateTo(context,const EstimateRequestScreen());
                                },
                                child: const LogoAppWidget(
                                    url: ImageApp.car1, width: 140, height: 140),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100),
                          child: loadingAppWidget(),
                        )),
                ),
              ),
            );
          },
        ));
  }
}

void bottomSheetCategories(
    {required BuildContext context, required List<Category> categories}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      // You can put your custom interface here
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  child: TextBoldeWidget(
                      fontWeight: FontWeight.w600,
                      text: 'All categories'.tr,
                      fontSize: 18,
                      textAlign: TextAlign.start),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear))
              ],
            ),
            GridViewCategories(categories: categories),
          ],
        ),
      );
    },
  );
}
