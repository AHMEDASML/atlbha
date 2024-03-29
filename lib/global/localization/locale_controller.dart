import 'package:atlobha/global/data/local/cache_helper.dart';
import 'package:atlobha/global/utils/key_shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


import '../../main.dart';

class LocalController extends GetxController {
  String selectedLanguage = 'en';

  @override
  void onInit() {
    selectedLanguage = CacheHelper.getData(key: LANGUAGE) ?? 'en';
    super.onInit();
  }

  void changeLang({required String codeLang}) {
    Locale locale = Locale(codeLang);
    CacheHelper.saveData(key: LANGUAGE, value: locale.toString());
    Get.updateLocale(locale);
  }
}

void changeLang({required String codeLang}) {
  Locale locale = Locale(codeLang);
  CacheHelper.saveData(key: LANGUAGE, value: locale.toString());

  Get.updateLocale(locale);
}
