import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/company_account/controller/user_company_controller.dart';
import 'package:atlobha/modules/account/company_account/view/screen/login_company_account.dart';
import 'package:atlobha/modules/account/widget/text_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegCompanyAccount extends StatefulWidget {
  const RegCompanyAccount({Key? key}) : super(key: key);

  @override
  State<RegCompanyAccount> createState() => _RegCompanyAccountState();
}

class _RegCompanyAccountState extends State<RegCompanyAccount> {
  final cont = Get.put(UserCompanyController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UserCompanyController>(
      builder: (con) {
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
              padding: const EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: SizeApp.screenSize.width / 1.1,
                  height: SizeApp.screenSize.height / 1.2,
                  child: Card(
                    color: ColorManager.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child: Text(
                                    'Register a corporate account'.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: ColorManager.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                TextFiledApp(
                                  keyboardType: TextInputType.text,
                                  controller: con.usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name'.tr;
                                    }
                                    return null;
                                  },
                                  textTitle: 'Name'.tr,
                                  icon: Icons.account_circle,
                                  hintText: 'Enter Name'.tr,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFiledApp(
                                  controller: con.phoneController,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your number'.tr;
                                    }
                                    return null;
                                  },
                                  textTitle: 'number'.tr,
                                  icon: Icons.mobile_friendly,
                                  hintText: 'Type the number'.tr,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFiledApp(
                                  controller: con.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password'.tr;
                                    }
                                    return null;
                                  },
                                  textTitle: 'password'.tr,
                                  icon: Icons.visibility_rounded,
                                  hintText: 'Enter the password'.tr,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFiledApp(
                                  controller: con.nameCompanyController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Name Company'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  textTitle: 'Company Name'.tr,
                                  icon: Icons.business,
                                  hintText: 'Enter company name'.tr,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                TextFiledApp(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your location Company'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  controller: con.locationCompanyController,
                                  textTitle: 'Company Address'.tr,
                                  icon: Icons.add_business,
                                  hintText: 'Enter company address'.tr,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                con.loading == false
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ButtonAppGold(
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              cont.registrationComp(
                                                  context: context);
                                            }
                                          },
                                          text: 'Sign Up'.tr,
                                        ),
                                      )
                                    : loadingAppWidget(),
                                const SizedBox(
                                  height: 6,
                                ),
                                Center(
                                  child: TextAuth(
                                    onTapTextTow: () {
                                      navigateAndFinish(
                                          context, LoginCompanyAccount());
                                    },
                                    textOne: 'do you have an account ?'.tr,
                                    textTow: 'Login'.tr,
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ));
  }
}
