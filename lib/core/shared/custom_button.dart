import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constant/color.dart';
import '../localization/changelocal.dart';

class CustomButton extends StatelessWidget {
  final String textbutton;
  final void Function()? onPressed;
   CustomButton({Key? key, required this.textbutton, this.onPressed})
      : super(key: key);
  LocaleController localController = Get.put(LocaleController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: MaterialButton(
        color:(!localController.isDark)? AppColor.primaryColor:AppColor.primaryColorDark,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(textbutton,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
