import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/user_account/controller/login_controller.dart';
import 'package:atlobha/modules/account/user_account/view/screen/reg_user_account.dart';
import 'package:atlobha/modules/account/widget/text_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUserAccount extends StatefulWidget {
  const LoginUserAccount({Key? key}) : super(key: key);

  @override
  State<LoginUserAccount> createState() => _LoginUserAccountState();
}

class _LoginUserAccountState extends State<LoginUserAccount> {
  final cont = Get.put(LoginController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<LoginController>(
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
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: SizeApp.screenSize.width / 1.1,
                  height: SizeApp.screenSize.height / 1.8,
                  child: Form(
                    key: _formKey,
                    child: Card(
                      color: ColorManager.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 20),
                                  child: Text(
                                    'sign in'.tr,
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your number'.tr;
                                    }
                                    return null;
                                  },
                                  controller: con.numberController,
                                  keyboardType: TextInputType.number,
                                  textTitle: 'number'.tr,
                                  icon: Icons.mobile_friendly,
                                  hintText: 'Type the number'.tr,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFiledApp(
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: con.passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your passord'.tr;
                                    }
                                    return null;
                                  },
                                  textTitle: 'password'.tr,
                                  icon: Icons.visibility_rounded,
                                  hintText: 'Enter the password'.tr,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                con.loading == false
                                    ? Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ButtonAppGold(
                                          text: 'sign in'.tr,
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // con.loginUser(
                                              //     context: context);

                                              cont.loginUser(context: context);
                                            }
                                          },
                                        ),
                                      )
                                    : loadingAppWidget(),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: TextAuth(
                                    onTapTextTow: () {
                                      navigateAndFinish(
                                          context, RegUserAccount());
                                    },
                                    textOne: 'If you do not have an account'.tr,
                                    textTow: 'Create account'.tr,
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
