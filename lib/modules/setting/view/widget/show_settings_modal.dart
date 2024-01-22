import 'package:atlobha/global/components/button_app_dark.dart';
import 'package:atlobha/global/components/button_app_gold.dart';
import 'package:atlobha/global/localization/locale_controller.dart';
import 'package:atlobha/global/utils/color_app.dart';
import 'package:atlobha/modules/splash/view/screen/select_language.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSettingsModal(BuildContext context) {

  String? selectedLanguage;

  List<String> fruits = ["Apple", "Banana"];

  void selectLanguage(String language) {
    // setState(() {
      selectedLanguage = language;
    // });
  }

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 240,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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

            Spacer(),
            ButtonAppGold(
              height: 50,
              text: 'save'.tr,
              onTap: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );
    },
  );
}
