import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/apptheme.dart';
import '../services/services.dart';

class LocaleController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;
  bool isDark = false;
  String lang = 'en';

  changeLang(String langcode) {
    lang = langcode;
    Locale locale = Locale(langcode);
    myServices.sharedPreferences.setString("lang", langcode);
    appTheme = langcode == "en" ? (!isDark)? themeEnglish : themeEnglishDark
              : (!isDark)? themeArabic : themeArabicDark;
    Get.updateLocale(locale);
    Get.changeTheme(appTheme);
                }

  changeTheme(bool iDark){
    isDark=iDark;
    Locale locale = Locale(lang);
    myServices.sharedPreferences.setString("lang", lang);
    appTheme = lang == "en" ? (!isDark)? themeEnglish : themeEnglishDark
        : (!isDark)? themeArabic : themeArabicDark;
    Get.updateLocale(locale);
    Get.changeTheme(appTheme);
  }



  @override
  void onInit() {
    //TODO: firebase notifications call..
    // requestPermissionNotifications();
    // fbmConfig();
    String? sharedPrefLang = myServices.sharedPreferences.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = const Locale("ar");
      appTheme = themeArabic;
    }

    super.onInit();
  }
}
