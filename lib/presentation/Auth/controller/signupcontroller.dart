// ignore_for_file: avoid_print

import 'package:cool_alert/cool_alert.dart';
import 'package:eqraa/presentation/Auth/data/datasource/verifycodesignup_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/apptheme.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/strings.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../routes.dart';
import '../data/datasource/signup_data.dart';

abstract class SignUpController extends GetxController {
  signUp();
  secures(bool secure);
  toLogin();
  verifyCodeSignUp();
}

class SignUpControllerImp extends SignUpController {
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController repassword;
  late TextEditingController username;

  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late RxBool? secure = true.obs;
  StatusRequest statusRequest = StatusRequest.none;

  SignupData signupData = SignupData(Get.find());
  VerifyCodeSignupData verifyCodeSignupData = VerifyCodeSignupData(Get.find());
  List data = [];

  @override
  signUp() async {
    var formdata = formState.currentState;
    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response =
          await signupData.postData(username.text, email.text, password.text);
      statusRequest = handlingData(response);
      print("Printing before-----------------");
      print("Response : $response");
      print("status request  : $statusRequest");
      // print(statusRequest);
      if (StatusRequest.success == statusRequest) {
        print(response);
        Get.rawSnackbar(
            title: "32".tr,
            icon: const Icon(
              Icons.check_box,
              color: AppColor.green,
            ),
            messageText: Text("58".tr),
            backgroundColor: AppColor.primaryColor,
            isDismissible: true);
        verifyCodeSignUp();
      } else  if (StatusRequest.failure == statusRequest){
        print("Email: ");
        print(email.text);
        CoolAlert.show(
            backgroundColor: AppColor.primaryColor,
            context: Get.overlayContext!,
            type: CoolAlertType.info,
            confirmBtnColor: AppColor.primaryColor,
            text: "${Strings.existed} Response : $response",
            onConfirmBtnTap: () {
              statusRequest = StatusRequest.failure;
            });
        statusRequest = StatusRequest.failure;
      } else  if (StatusRequest.serverFailure == statusRequest){
        print("Email: ");
        print(email.text);
        CoolAlert.show(
            backgroundColor: AppColor.primaryColor,
            context: Get.overlayContext!,
            type: CoolAlertType.info,
            confirmBtnColor: AppColor.primaryColor,
            text: "Server Failure $response",
            onConfirmBtnTap: () {
              statusRequest = StatusRequest.failure;
            });
        statusRequest = StatusRequest.failure;
      }

      update();
    } else {
      print("Not Valid");
    }
    update();
  }

  @override
  toLogin() {
    Get.offAndToNamed(AppRoutes.login);
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    repassword = TextEditingController();

    username = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    repassword.dispose();
    username.dispose();

    super.dispose();
  }

  @override
  secures(bool? secure) {
    secure = !secure!;
  }

  @override
  verifyCodeSignUp() {
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

  goToSuccessSignUp(String verifyCode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await verifyCodeSignupData.postdata(verifyCode, email.text);
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      // if (response['status'] == "success") {
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
    await Future.delayed(const Duration(seconds:1));
    Get.offNamed(AppRoutes.login);
  }
}
