// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/class/handlingdataview.dart';
import '../../../../core/constant/color.dart';
import '../../../../core/functions/valid_input.dart';
import '../../../widgets/auth/custom_button_auth.dart';
import '../../../widgets/auth/custom_password_textform.dart';
import '../../../widgets/auth/custom_text_body_auth.dart';
import '../../../widgets/auth/custom_title_auth.dart';
import '../controller/resetpassword_controller.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Get.put(ResetPasswordControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      appBar: AppBar(
        foregroundColor: AppColor.primaryColor,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: AppColor.backGroundColor,
        title: Text(
          "Reset Password",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColor.gray,
              ),
        ),
      ),
      body: GetBuilder<ResetPasswordControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: Form(
            key: controller.formState,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              child: Column(
                children: [
                  const CustomTitleAuth(title: "New Password"),
                  // const LogoAuth(),
                  const CustomTextBodyAuth(
                      body:
                          "Enter Your New Password \n Don't Share With Anyone."),
                  const SizedBox(
                    height: 20,
                  ),

                  AuthPasswordTextFormField(
                    validator: (val) {
                      return validInput(val!, 5, 50, "password");
                    },
                    mycontroller: controller.password,
                    textBox: "Password",
                    hintText: "Enter Your New Password ",
                  ),

                  AuthPasswordTextFormField(
                    validator: (val) {
                      return validInput(val!, 5, 50, "password");
                    },
                    mycontroller: controller.password_confirmation,
                    textBox: " Confirm Password",
                    hintText: "Re Enter Your New Password ",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomBottomAuth(
                    text: 'Submit',
                    onPressed: () {
                      controller.goToSuccessResetPassword();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
