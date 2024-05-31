// ignore_for_file: avoid_print

import 'package:cool_alert/cool_alert.dart';
import 'package:eqraa/core/app_export.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../data/forgot_password_data.dart';

abstract class ForgotPasswordController extends GetxController {
  checkCode();
}

class ForgotPasswordControllerImp extends ForgotPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  StatusRequest statusRequest = StatusRequest.none;
  ForgotPasswordData forgotPasswordData = ForgotPasswordData(Get.find());

  @override
  checkCode() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await forgotPasswordData.postdata(
        email.text,
      );
      statusRequest = handlingData(response);
      print("Status Request : $statusRequest");
      if (StatusRequest.success == statusRequest) {


          Get.offAndToNamed(AppRoutes.verifyCode,
              arguments: {"email": email.text}
          );
        } else {
          update();
          // Get.defaultDialog(title: "Warning", middleText: "Email not found");
          CoolAlert.show(
              context: Get.overlayContext!,
              type: CoolAlertType.warning,
              text: "Email not found",
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
    email = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    email.dispose();

    super.dispose();
  }
}
