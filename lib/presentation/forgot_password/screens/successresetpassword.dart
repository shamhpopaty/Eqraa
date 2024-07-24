import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/color.dart';
import '../../../widgets/auth/custom_button_auth.dart';
import '../controller/successresetpassword_controller.dart';

class SuccessResetPassword extends StatelessWidget {
  const SuccessResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessResetPasswordControllerImp controller =
        Get.put(SuccessResetPasswordControllerImp());
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColor.backGroundColor,
        title: Text(
          "Success",
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColor.gray,
              ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Icon(Icons.check_circle_outline,
                size: 200, color: AppColor.primaryColor),
          ),
          const Spacer(),
          CustomBottomAuth(
            text: 'Go To Login',
            onPressed: () {
              controller.goToLogin();
            },
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
