import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/localization/changelocal.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constant/apptheme.dart';
import '../core/constant/color.dart';
import '../core/functions/alert_alarm.dart';
import '../core/services/services.dart';

class DropDownList extends StatelessWidget {
   DropDownList({super.key,this.isThemeApp= false});
  bool isThemeApp =false;
  MyServices myServices = Get.find();
   LocaleController controller = Get.put(LocaleController());
   Locale? language;

   ThemeData appTheme = themeEnglish;

   // controller.change
   changeLang(String langcode) {
     Locale locale = Locale(langcode);
     myServices.sharedPreferences.setString("lang", langcode);
     appTheme = langcode == "en" ? themeEnglish : themeArabic;
     Get.updateLocale(locale);
     Get.changeTheme(appTheme);
   }
   @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(

      hint: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
            width: 400,
            child: Text(
              isThemeApp?"145".tr: "144".tr,
              // textAlign: TextAlign.left,
              style: TextStyle(color:(!localController.isDark)? AppColor.black:AppColor.white,
              ),
            )),
      ),
      underline: Divider(
        color: Colors.white10,
        thickness: 2,
      ),
      isExpanded: true,
      items:isThemeApp?[
        "light",
        "dark"
      ].map((e) => DropdownMenuItem<String>(
      child: Text(e),
      value: e,
    ))
         .toList(): [
        "Ar",
        "EN"
      ]
          .map((e) => DropdownMenuItem<String>(
        child: Text(e),
        value: e,
      ))
          .toList(),
      borderRadius: BorderRadius.circular(15), onChanged: (String? value) {
        if(!isThemeApp)
        {
          if(value == 'Ar'){
            // changeLang('ar');
            controller.changeLang('ar');

          }else {
            controller.changeLang('en');
          }
        }else {
          if(value == 'light'){
            controller.changeTheme(false);
          }else {
            controller.changeTheme(true);
          }
        }

    },
    );
  }
}
