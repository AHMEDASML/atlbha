import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/user_account/controller/user_auth_controller.dart';
import 'package:atlobha/modules/account/user_account/view/screen/login_user_account.dart';
import 'package:atlobha/modules/account/widget/text_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegUserAccount extends StatefulWidget {
  const RegUserAccount({Key? key}) : super(key: key);

  @override
  State<RegUserAccount> createState() => _RegUserAccountState();
}

class _RegUserAccountState extends State<RegUserAccount> {
  final cont = Get.put(UserAuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<UserAuthController>(
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
                    height: SizeApp.screenSize.height / 1.4,
                    child: Card(
                      color: ColorManager.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40, horizontal: 20),
                                    child: Text(
                                      'Sign Up'.tr,
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
                                    textTitle: 'Name'.tr,
                                    controller: cont.nameController,
                                    icon: Icons.account_circle,
                                    hintText: 'Enter Name'.tr,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFiledApp(
                                    keyboardType: TextInputType.number,
                                    controller: cont.numberController,
                                    textTitle: 'number'.tr,
                                    icon: Icons.mobile_friendly,
                                    hintText: 'Type the number'.tr,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your number'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFiledApp(
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: cont.passwordController,
                                    textTitle: 'password'.tr,
                                    icon: Icons.visibility_rounded,
                                    hintText: 'Enter the password'.tr,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password'.tr;
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  con.loading == false
                                      ? Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: ButtonAppGold(
                                            text: 'Sign Up'.tr,
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                // If form is valid, proceed with registration

                                                cont.registration(context: context);
                                                // cont.registration(
                                                //     context: context);
                                              }
                                            },
                                          ),
                                        )
                                      : loadingAppWidget(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                    Center(
                                    child: TextAuth(
                                      onTapTextTow: (){
                                        navigateAndFinish(context, LoginUserAccount());
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
      ),
    );
  }
}
