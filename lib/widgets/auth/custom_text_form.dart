import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../core/localization/changelocal.dart';

LocaleController localController = Get.put(LocaleController());

class AuthTextFormField extends StatelessWidget {
  final String? hintText;
  final IconData? iconPrefix;
  final IconData? iconSuffix;
  final TextEditingController? mycontroller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardtype;
  final Function(String)? onChanged; // إضافة onChanged

  const AuthTextFormField({
    super.key,
    this.hintText,
    this.iconSuffix,
    this.mycontroller,
    this.keyboardtype,
    this.validator,
    this.iconPrefix,
    this.onChanged, required String textBox, // تأكد من تمرير onChanged هنا
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        cursorColor: (!localController.isDark)
            ? AppColor.primaryColor
            : AppColor.primaryColorDark,
        textDirection: TextDirection.ltr,
        keyboardType: keyboardtype,
        controller: mycontroller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged, // تمرير onChanged إلى TextFormField
        style: TextStyle(
          color: (!localController.isDark)
              ? AppColor.primaryColor
              : AppColor.primaryColorDark,
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          hintText: hintText,
          prefixIcon: Icon(
            iconPrefix,
            color: (!localController.isDark) ? AppColor.gray : AppColor.white,
          ),
          suffixIcon: Icon(
            iconSuffix,
            color: (!localController.isDark)
                ? AppColor.primaryColor
                : AppColor.primaryColorDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.gray,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.gray,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: (!localController.isDark)
              ? AppColor.fourthColor
              : AppColor.fourthColorDark,
        ),
      ),
    );
  }
}
