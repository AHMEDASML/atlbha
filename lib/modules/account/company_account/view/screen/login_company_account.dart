import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/company_account/view/screen/reg_company_account.dart';
import 'package:atlobha/modules/account/user_account/controller/login_controller.dart';
import 'package:atlobha/modules/account/widget/text_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../global/common/loading_app.dart';

class LoginCompanyAccount extends StatefulWidget {
  const LoginCompanyAccount({Key? key}) : super(key: key);

  @override
  State<LoginCompanyAccount> createState() => _LoginCompanyAccountState();
}

class _LoginCompanyAccountState extends State<LoginCompanyAccount> {
  final cont = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (con){
        return Stack(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70,),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: SizeApp.screenSize.width / 1.1,
                  height: SizeApp.screenSize.height / 1.8,
                  child: Card(
                    color: ColorManager.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 20),
                                child: Text(
                                  'Login to the company account'.tr,
                                  style:
                                  Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: ColorManager.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              TextFiledApp(
                                controller: cont.numberController,
                                textTitle: 'number'.tr,
                                icon: Icons.mobile_friendly,
                                hintText: 'Type the number'.tr,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFiledApp(
                                controller: cont.passwordController,
                                textTitle: 'password'.tr,
                                icon: Icons.visibility_rounded,
                                hintText: 'Enter the password'.tr,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:  con.loading == false? ButtonAppGold(
                                  onTap: (){
                                    cont.loginUser(context: context);
                                  },
                                  text: 'sign in'.tr,
                                ): loadingAppWidget(),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextAuth(
                                  onTapTextTow: () {
                                    navigateAndFinish(context, const RegCompanyAccount());
                                  },
                                  textOne: 'If you do not have an account'.tr,
                                  textTow: 'Create account'.tr,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },)

    );
  }
}
