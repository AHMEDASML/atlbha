import 'package:atlobha/global/common/functions_app.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/modules/account/account_type/view/screen/account_type_screen.dart';
import 'package:atlobha/modules/car/view/screen/my_car_screen.dart';
import 'package:atlobha/modules/setting/view/widget/show_settings_modal.dart';
import 'package:atlobha/modules/setting/view/widget/widget_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final token = CacheHelper.getData(key: TOKEN);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: ProfileWidgetImageLogin(
              onTap: (){
                if(token == null){
                  navigateTo(context,AccountTypeScreen());
                }

              },
              text: token == null ? 'sign in'.tr : 'Show profile'.tr,
            ),

          ),
          const SizedBox(
            height: 30,
          ),
          lineSettingWidget(),
          token != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    listTileTitleWidgetSetting(
                        context: context,
                        text: 'arithmetic'.tr,
                        icon: Icons.person_2_outlined),
                    lineSubSettingWidget(),
                    listTileSubWidgetSetting(
                        context: context,
                        text: 'My cars'.tr,
                        onTap: () {
                          navigateTo(context, MyCarScreen());
                        }),
                    lineSubSettingWidget(),
                    GestureDetector(
                      onTap: _showSignOutConfirmation,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Text('sign out'.tr,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: ColorManager.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        'delete account'.tr,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.red.shade600,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                    lineSubSettingWidget(),
                    lineSubSettingWidget(),
                    lineSubSettingWidget(),
                  ],
                )
              : Container(),
          listTileTitleWidgetSetting(context: context, text: 'Settings'.tr),
          lineSubSettingWidget(),
          listTileSubWidgetSetting(
              onTap: () => showSettingsModal(context),
              context: context,
              text: 'App language'.tr),
          const SizedBox(
            height: 5,
          ),
          lineSettingWidget(),
          const SizedBox(
            height: 5,
          ),
          listTileTitleWidgetSetting(
              context: context,
              text: 'Contact us'.tr,
              icon: Icons.account_balance_wallet_rounded),
          const SizedBox(
            height: 5,
          ),
          lineSubSettingWidget(),
          const SizedBox(
            height: 5,
          ),
          listTileSubWidgetSetting(context: context, text: 'Contact us'.tr),
          const SizedBox(
            height: 5,
          ),
          lineSubSettingWidget(),
          const SizedBox(
            height: 5,
          ),
          listTileSubWidgetSetting(
              context: context, text: 'Terms & Conditions'.tr),
        ],
      ),
    );
  }

  void _showSignOutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'.tr),
          content: Text('Do you really want to sign out?'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('No'.tr),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            TextButton(
              child: Text('Yes'.tr),
              onPressed: () {
                print('Yes'.tr); // Handle the sign out logic here
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
