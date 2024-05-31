// ignore_for_file: deprecated_member_use


import 'package:eqraa/core/constant/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/color.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../widgets/auth/custom_text_body_auth.dart';
import '../../../widgets/auth/custom_title_auth.dart';
import '../controller/verifycode_controller.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Get.put(VerifyCodeControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        foregroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColor.backGroundColor,
        title: Text(
          "Verification Code",
          style:MyTextStyle.title
        ),
      ),
      body: GetBuilder<VerifyCodeControllerImp>(
          builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Container(
                  padding:
                       EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      const CustomTitleAuth(title: "Check Code"),
                      // const LogoAuth(),
                       CustomTextBodyAuth(
                          body: "Please Enter The Digit Code Sent To ${controller.email}"),

                      const SizedBox(
                        height: 20,
                      ),

                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: OtpTextField(
                          fieldWidth: 50.0,
                          borderRadius: BorderRadius.circular(20),
                          numberOfFields: 6,
                          borderColor: const Color(0xFF512DA8),
                          //set to true to show as box or false to show as dash
                          showFieldAsBox: true,
                          //runs when a code is typed in
                          onCodeChanged: (String code) {
                            //handle validation or checks here
                          },
                          //runs when every textField is filled
                          onSubmit: (String verificationCode) {
                            controller.goToResetPassword(verificationCode);
                          }, // end onSubmit
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.resend();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.refresh_outlined),
                            Text("52".tr),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }
}
