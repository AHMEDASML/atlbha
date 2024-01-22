import 'package:atlobha/global/Common/loading_app.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_filed_app.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/banana_account/controller/user_banana_controller.dart';
import 'package:atlobha/modules/account/widget/text_auth.dart';
import 'package:atlobha/modules/account/widget/upload_images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegBananaAccount extends StatefulWidget {
  const RegBananaAccount({Key? key}) : super(key: key);

  @override
  State<RegBananaAccount> createState() => _RegBananaAccountState();
}

class _RegBananaAccountState extends State<RegBananaAccount> {
  final cont = Get.put(UserBananaController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<UserBananaController>(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Text(
                                  'Distributor account registration'.tr,
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
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFiledApp(

                                        textTitle: 'Name'.tr,
                                        icon: Icons.account_circle,
                                        hintText: 'Enter Name'.tr,
                                        controller: con.usernameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your name'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFiledApp(
                                        textTitle: 'number'.tr,
                                        icon: Icons.mobile_friendly,
                                        hintText: 'Type the number'.tr,
                                        controller: con.phoneController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your number'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFiledApp(
                                        textTitle: 'password'.tr,
                                        icon: Icons.visibility_rounded,
                                        hintText: 'Enter the password'.tr,
                                        controller: con.passwordController,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password'.tr;
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      TextFiledApp(
                                        keyboardType: TextInputType.number,
                                        controller: con.numberCarController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your car number'.tr;
                                          }
                                          return null;
                                        },
                                        textTitle: 'car number'.tr,
                                        icon: Icons.visibility_rounded,
                                        hintText: 'Enter the car number'.tr,
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                    ],
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SizedBox(
                                    width: SizeApp.screenSize.width,
                                    height: 200,
                                    child: UploadImages(
                                      onImagePicked: (file) {
                                        cont.setImage(file);
                                      },
                                    )),
                              ),
                              con.loading == false? Padding(
                                padding: EdgeInsets.all(8.0),
                                child: ButtonAppGold(
                                  text: 'Sign Up'.tr,
                                  onTap: (){



                                    if (_formKey.currentState!
                                        .validate()) {

                                      con.registrationBenana(
                                          context: context);
                                    }

                                  },
                                ),
                              ):  loadingAppWidget(),
                              const SizedBox(
                                height: 6,
                              ),
                               Center(
                                child: TextAuth(
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
          ],
        );
      },
    ));
  }
}
