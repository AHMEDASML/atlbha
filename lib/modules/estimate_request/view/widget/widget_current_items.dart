import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/image_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/my_orders/controller/my_orders_controller.dart';
 import 'package:atlobha/modules/my_orders/view/widget/current_carts_request_card.dart';
import 'package:atlobha/modules/my_orders/view/widget/estimation_request_card.dart';
import 'package:atlobha/modules/my_orders/view/widget/parts_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
  class WidgetCurrentItems extends StatefulWidget {
  const WidgetCurrentItems({Key? key}) : super(key: key);

  @override
  State<WidgetCurrentItems> createState() => _WidgetCurrentItemsState();
}

class _WidgetCurrentItemsState extends State<WidgetCurrentItems> {
  final token = CacheHelper.getData(key: TOKEN);
  final MyOrdersController ordersController = Get.find<MyOrdersController>();


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (ordersController.loading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (ordersController.myOrdersModel == null) {
        return _noOrdersWidget();
      } else {
        return ListView(
          children: [
            if (ordersController.myOrdersModel!.currentRequests.currentCartsRequests.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: TextBoldeWidget(
                  fontWeight: FontWeight.w500,
                  text: 'Basket requests'.tr,
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ...ordersController.myOrdersModel!.currentRequests.currentCartsRequests.map(
                  (cartRequest) => CurrentCartsRequestCard(currentCartsRequest: cartRequest),
            ),
            if (ordersController.myOrdersModel!.currentRequests.estimisionRequests.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: TextBoldeWidget(
                  fontWeight: FontWeight.w500,
                  text: 'Application requests'.tr,
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ...ordersController.myOrdersModel!.currentRequests.estimisionRequests.map(
                  (estimationRequest) => EstimationRequestCard(estimationRequest: estimationRequest),
            ),
            if (ordersController.myOrdersModel!.currentRequests.partsRequests.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: TextBoldeWidget(
                  fontWeight: FontWeight.w500,
                  text: 'Spare parts requests'.tr,
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ...ordersController.myOrdersModel!.currentRequests.partsRequests.map(
                  (partsRequest) => PartsRequestCard(partsRequest: partsRequest),
            ),
          ],
        );
      }
    });
  }

  Widget _noOrdersWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: Image.asset(
            ImageApp.beforeLoggingIn,
            width: 200,
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: TextBoldeWidget(
              text: token == null ? 'There are no requests yet'.tr : 'You must log in'.tr,
              fontSize: 20,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}








