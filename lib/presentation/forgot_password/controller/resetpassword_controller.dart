// ignore_for_file: avoid_print

import 'package:cool_alert/cool_alert.dart';
import 'package:eqraa/core/app_export.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../data/resetpassword_data.dart';

abstract class ResetPasswordController extends GetxController {
  checkPassword();
  goToSuccessResetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController password;

  String? code;
  late TextEditingController password_confirmation;
  StatusRequest statusRequest = StatusRequest.none;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  @override
  checkPassword() {}

  @override
  goToSuccessResetPassword() async {
    print("Data :  code : $code , Password : ${password.text} , confirm password : ${password_confirmation.text}");
    var formdata = formState.currentState;
    if (password.text != password_confirmation.text) {
      Get.defaultDialog(title: "Warning", middleText: "Password Doesn't match");
      return statusRequest = StatusRequest.failure;
    }
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await resetPasswordData.postdata(code!, password.text, password_confirmation.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        print(statusRequest);
          Get.offAndToNamed(
            AppRoutes.successResetPassword,
          );
        } else {
          CoolAlert.show(
              context: Get.overlayContext!,
              type: CoolAlertType.warning,
              text: "Try Again",
              confirmBtnColor: AppColor.primaryColor,
              onConfirmBtnTap: () {
                statusRequest = StatusRequest.failure;
                update();
              });
          return statusRequest = StatusRequest.failure;
        }
      update();
    } else {
      print("Not Valid");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    password = TextEditingController();
    password_confirmation = TextEditingController();
    code = Get.arguments['code'];
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    password.dispose();
    password_confirmation.dispose();

    super.dispose();
  }
}

mixin successResetPassword {
}
