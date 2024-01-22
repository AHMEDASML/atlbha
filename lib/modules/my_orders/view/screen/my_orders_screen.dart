import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/estimate_request/view/widget/widget_current_items.dart';
import 'package:atlobha/modules/estimate_request/view/widget/widget_previous_items.dart';
import 'package:atlobha/modules/my_orders/controller/my_orders_controller.dart';
import 'package:atlobha/modules/my_orders/view/widget/screen_before_logging_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global/common/loading_app.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MyOrdersController cont = Get.put(MyOrdersController());
  final token = CacheHelper.getData(key: TOKEN);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (token != null) {
      cont.getMyOrders(context: context);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('My Orders'.tr),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                  child: TextBoldeWidget(
                    text: 'Present'.tr,
                    fontSize: 14,
                  ),
                ),
                Tab(
                  child: TextBoldeWidget(
                    text: 'Previous'.tr,
                    fontSize: 14,
                  ),
                ),
              ],
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Creates border
                color: ColorManager.yellow2
                    .withOpacity(0.8), // Change your color here
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder<MyOrdersController>(
        init: MyOrdersController(),
        builder: (_) {
          if (cont.loading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return TabBarView(
              controller: _tabController,
              children: const <Widget>[
                WidgetCurrentItems(),
                WidgetPreviousItems(),
              ],
            );
          }
        },
      ),
    );
  }
}
