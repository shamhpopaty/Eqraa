import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/apptheme.dart';
import '../constant/color.dart';

Future<bool> alertalarmApp() {


  AwesomeDialog(
      context: Get.context!,

      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "60".tr,
      titleTextStyle: MyTextStyle.title.copyWith(color: AppColor.primaryColor),
      desc: "164".tr,
      btnCancelOnPress: () {},
      btnOkText: "61".tr,
      btnOkOnPress: (){  Get.toNamed(AppRoutes.homePage);},
      btnOkColor: AppColor.primaryColor,
      btnCancelColor: AppColor.gray)
      .show();
  return Future.value(true);
}
