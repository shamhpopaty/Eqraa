// ignore_for_file: avoid_print, unused_local_variable

import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/apptheme.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';
import '../../../routes.dart';
import '../data/datasource/login_data.dart';
import '../data/datasource/verifycodesignup_data.dart';
import '../../../models/user_model.dart';

abstract class LoginController extends GetxController {
  login();
  toForgotPassword();
  toSignUp();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  VerifyCodeSignupData verifyCodeSignupData = VerifyCodeSignupData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  late UserModel userModel = UserModel();
  RxBool secure = true.obs;

  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();
  @override
  void onInit() {
    userModel = UserModel();
    FirebaseMessaging.instance.getToken().then((value) {
      print("Token is : ");
      print(value);
      String? token = value;
      update();
    });

    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  showPassword() {
    secure = secure == true.obs ? false.obs : true.obs;
    update();
  }

  @override
  login() async {
    if (formstate.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postdata(email.text, password.text);
      print("=============================== Controller $response ");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          userModel = UserModel.fromJson(response['data']);
          // if (userModel.usersApprove == "1") {
          // data.addAll(response['data']);

          myServices.sharedPreferences.setString("id", userModel.usersId!);
          myServices.sharedPreferences
              .setString("username", userModel.usersName!);
          myServices.sharedPreferences
              .setString("email", userModel.usersEmail!);

          myServices.sharedPreferences.setString("step", "2");
          String? userid = myServices.sharedPreferences.getString("id");

          ///TODO: FireBase Subscribe to topic
          FirebaseMessaging.instance.subscribeToTopic("admin");
          FirebaseMessaging.instance.subscribeToTopic("admin$userid");

          Get.snackbar(
              "Welcome ${myServices.sharedPreferences.getString("username")} !",
              "57".tr,
              icon: const Icon(
                Icons.check_box,
                color: AppColor.green,
              ),
              colorText: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              isDismissible: true);
          Get.offAllNamed(AppRoutes.homePage);
        } else {
          statusRequest = StatusRequest.success;
          //verify ..
          showBottomSheet();
        }
      } else {
        CoolAlert.show(
          context: Get.overlayContext!,
          type: CoolAlertType.error,
          backgroundColor: AppColor.primaryColor,
          confirmBtnColor: AppColor.primaryColor,
          text: "Email Or Password Not Correct",
        );
        // Get.defaultDialog(
        //     title: "ُWarning", middleText: "Email Or Password Not Correct");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  toForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }

  goToSuccessSignUp(String verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifyCodeSignupData.postdata(verifyCode, email.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.back();
        success();
      } else {
        CoolAlert.show(
            context: Get.overlayContext!,
            type: CoolAlertType.error,
            text: "Verify Code Is Not Correct",
            confirmBtnText: "Try Again",
            confirmBtnColor: AppColor.primaryColor,
            onConfirmBtnTap: () {
              statusRequest = StatusRequest.none;
              update();
            });

        return statusRequest = StatusRequest.none;
      }
    }
    update();
  }

  resend() {
    verifyCodeSignupData.resendData(email.text);
    Get.rawSnackbar(
        title: "32".tr,
        icon: const Icon(
          Icons.refresh,
          // color: AppColor.primaryColor,
        ),
        messageText: Text(
          "52".tr,
          style: const TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.thirdColor,
        isDismissible: true);
  }

  logOutDefault() {
    CoolAlert.show(
        context: Get.context!,
        cancelBtnText: "62".tr,
        confirmBtnText: "61".tr,
        showCancelBtn: true,
        backgroundColor: AppColor.primaryColor,
        animType: CoolAlertAnimType.rotate,
        borderRadius: BorderSide.strokeAlignCenter,
        type: CoolAlertType.warning,
        loopAnimation: true,
        confirmBtnColor: AppColor.primaryColor,
        title: "63".tr,
        text: "64".tr,
        onConfirmBtnTap: () async {
          myServices.sharedPreferences.clear();

          Get.rawSnackbar(
            title: "32".tr,
            backgroundColor: AppColor.secondColor,
            icon: const Icon(
              Icons.logout_outlined,
              color: AppColor.white,
            ),
            messageText: Text(
              "55".tr,
              style: const TextStyle(color: AppColor.white),
            ),
          );
          await Future.delayed(const Duration(milliseconds: 500));
          Get.toNamed(AppRoutes.language);
          // update();
        });
  }

  showBottomSheet() {
    showMaterialModalBottomSheet(
      backgroundColor: AppColor.secondColor,
      animationCurve: const ElasticInCurve(),
      context: Get.context!,
      builder: (context) => SizedBox(
        height: 500,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "27".tr,
              style: MyTextStyle.title.copyWith(color: AppColor.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Please Enter The Digit Code Sent To \n ${email.text}          ",
                style: MyTextStyle.body.copyWith(color: AppColor.white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            HandlingDataView(
              shimmer: true,
              widget: Directionality(
                textDirection: TextDirection.ltr,
                child: OtpTextField(
                  fillColor: AppColor.white,
                  textStyle: MyTextStyle.body.copyWith(color: AppColor.white),
                  fieldWidth: 50.0,
                  borderRadius: BorderRadius.circular(20),
                  numberOfFields: 5,
                  borderColor: const Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textField is filled
                  onSubmit: (String verificationCode) {
                    goToSuccessSignUp(verificationCode);
                  }, // end onSubmit
                ),
              ),
              imageHeight: 100,
              imageWidth: 100,
              statusRequest: statusRequest,
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                resend();
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
    );
  }

  void success() async {
    showMaterialModalBottomSheet(
      backgroundColor: AppColor.secondColor,
      // duration: const Duration(seconds: 3),
      animationCurve: const ElasticInCurve(),
      context: Get.context!,
      builder: (context) => Container(
        height: 400,
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          const Center(
              child: Icon(
            Icons.check_circle_outline,
            size: 200,
            color: AppColor.green,
          )),
          Text("37".tr,
              style: MyTextStyle.titleLarge
                  .copyWith(fontSize: 30, color: AppColor.white)),
          Text("38".tr,
              style: MyTextStyle.title
                  .copyWith(fontSize: 30, color: AppColor.white)),
          const Spacer(),
        ]),
      ),
    );
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }

  @override
  toSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }
}
