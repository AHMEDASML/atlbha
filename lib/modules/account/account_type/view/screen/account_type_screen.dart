import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/banana_account/view/screen/reg_banana_account.dart';
import 'package:atlobha/modules/account/company_account/view/screen/reg_company_account.dart';
import 'package:atlobha/modules/account/user_account/view/screen/reg_user_account.dart';
import 'package:atlobha/modules/layout/view/layout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountTypeScreen extends StatefulWidget {
  const AccountTypeScreen({Key? key}) : super(key: key);

  @override
  State<AccountTypeScreen> createState() => _AccountTypeScreenState();
}

class _AccountTypeScreenState extends State<AccountTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeApp.screenSize.height / 2,
            color: ColorManager.yellow2,
            child: const Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: LogoAppWidget(),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: SizeApp.screenSize.width / 1.1,
              height: SizeApp.screenSize.height / 2,
              child: Card(
                color: ColorManager.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Select the account type'.tr,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: ColorManager.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: ButtonAppGold(
                      onTap: (){
                        navigateTo(context,RegUserAccount());
                      },
                      text: 'user'.tr,

                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: ButtonAppGold(
                      onTap: (){
                        navigateTo(context,RegCompanyAccount());
                      },
                      text: 'company'.tr,
                  ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
                      child: ButtonAppGold(

                      onTap: (){
                        navigateTo(context,RegBananaAccount());
                      },
                      text: 'distributor'.tr,
                  ),
                    ),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              navigateAndFinish(context,LayoutScreen());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Continue as a visitor'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: ColorManager.yellow2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
