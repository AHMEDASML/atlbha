import 'package:atlobha/global/Common/functions_app.dart';
import 'package:atlobha/global/components/button_app_dark.dart';
import 'package:atlobha/global/components/logo_app_widget.dart';
import 'package:atlobha/global/components/text_bolde_widget.dart';
import 'package:atlobha/global/components/text_nourmal_widget.dart';
import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/localization/locale_controller.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:atlobha/global/utils/size_app.dart';
import 'package:atlobha/modules/account/account_type/view/screen/account_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  String? selectedLanguage;

  List<String> fruits = ["Apple", "Banana"];

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  @override
  void initState() {
    selectLanguage('Arabic');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: SizeApp.screenSize.height / 1.5,
            child: Container(
              color: ColorManager.yellow2,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LogoAppWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    TextBoldeWidget(
                      text: 'Atlobha',
                    ),
                    TextBoldeWidget(
                      text: 'اطلبها',
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: SizeApp.screenSize.height / 1.8,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBoldeWidget(
                              text: 'Welcome to'.tr,
                              color: ColorManager.black4,
                              fontSize: 36),
                          TextBoldeWidget(
                              text: 'Atlobha',
                              color: ColorManager.black4,
                              fontSize: 36),
                          const SizedBox(
                            height: 20,
                          ),
                          TextNourmalWidget(
                            text:
                                'Choose the language that suits your device. You can change the language later from the settings'
                                    .tr,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ItemSelectLang(
                            isSelected: selectedLanguage == 'Arabic',
                            text: 'Arabic',
                            onTap: () {
                              changeLang(codeLang: 'ar');
                              selectLanguage('Arabic');
                              // lang='ar';
                              // navigateAndFinish(context,ChooseAccountScreen());
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Divider(
                              height: 3,
                              color: ColorManager.grey,
                            ),
                          ),
                          ItemSelectLang(
                            isSelected: selectedLanguage == 'English',
                            text: 'English',
                            onTap: () {
                              changeLang(codeLang: 'en');
                              selectLanguage('English');
                              // lang='en';
                              // navigateAndFinish(context,ChooseAccountScreen());
                            },
                          ),
                          ButtonAppDark(
                            text: 'CONTINUE'.tr,
                            onTap: () {
                              CacheHelper.saveData(
                                  value:
                                      'The transition was completed successfully',
                                  key: IfHeComesIn);

                              navigateTo(context, AccountTypeScreen());
                            },
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemSelectLang extends StatelessWidget {
  final String text;
  final bool isSelected;
  final void Function() onTap;

  const ItemSelectLang({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            SizedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: ColorManager.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
              ),
            ),
            isSelected
                ? Container(
                    decoration: BoxDecoration(
                      color: ColorManager.yellow2,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: ColorManager.white,
                    ),
                  )
                : Container(
                    // خلفية خالية في حالة عدم التحديد
                    ),
          ],
        ),
      ),
    );
  }
}
