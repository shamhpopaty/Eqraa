// ignore_for_file: avoid_print, unused_local_variable

import 'package:cool_alert/cool_alert.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:eqraa/presentation/forgot_password/screens/forgotpassword.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/class/status_request.dart';
import '../../../core/constant/apptheme.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/strings.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';
import '../../../routes.dart';
import '../../forgot_password/screens/forgotpassword.dart';
import '../data/datasource/login_data.dart';
import '../data/datasource/verifycodesignup_data.dart';
import '../../../models/user_model.dart';

abstract class LoginController extends GetxController {
  login();
  toForgotPassword();
  toSignUp();
  ForgotPassword();
}

class LoginControllerImp extends LoginController {
  LoginData loginData = LoginData(Get.find());
  VerifyCodeSignupData verifyCodeSignupData = VerifyCodeSignupData(Get.find());

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  late TextEditingController email;
  late TextEditingController password;
  late UserModel userModel = UserModel();
  List messageFailure = [];
  RxBool secure = true.obs;


  StatusRequest statusRequest = StatusRequest.none;

  MyServices myServices = Get.find();

  get books => null;
  @override
  void onInit() {
    userModel = UserModel();
    // FirebaseMessaging.instance.getToken().then((value) {
    //   print("Token is : ");
    //   print(value);
    //   String? token = value;
    //   update();
    // });

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
        // if (response['status'] == "success") {
        userModel = UserModel.fromJson(response['user']);
        if (userModel.verifiedAt != null) {
          String? token= response['token'];
          myServices.sharedPreferences
              .setString("token", token!);
          // data.addAll(response['data']);
          print("Success Response :  $response");
          myServices.sharedPreferences.setString("id", userModel.usersId!);
          myServices.sharedPreferences
              .setString("username", userModel.usersName!);
          myServices.sharedPreferences
              .setString("email", userModel.usersEmail!);


          myServices.sharedPreferences.setString("step", "2");
          String? userid = myServices.sharedPreferences.getString("id");

          ///TODO: FireBase Subscribe to topic
          // FirebaseMessaging.instance.subscribeToTopic("admin");
          // FirebaseMessaging.instance.subscribeToTopic("admin$userid");

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

          if(userModel.isAdmin==0){Get.offAllNamed(AppRoutes.homePage);}else {
            //TODO: Admin Home Page

          }

          // Case the account is not verified.
        } else {
          verifyCodeSignUp();
        }
      }
      // Case Status Code is Failure ( email or password wrong )
      else if (StatusRequest.failure == statusRequest) {
        // messageFailure.addAll(response['password']);
        // messageFailure.isEmpty
        //     ? messageFailure.addAll(response['email'])
        //     : ['invalid'];
        print("Email: ");
        print(email.text);
        CoolAlert.show(
            backgroundColor: AppColor.primaryColor,
            context: Get.overlayContext!,
            type: CoolAlertType.info,
            confirmBtnColor: AppColor.primaryColor,
            text: "${Strings.existed} Response : $response ",
            onConfirmBtnTap: () {
              // statusRequest = StatusRequest.failure;
            });
        statusRequest = StatusRequest.failure;
      } else if (StatusRequest.serverFailure == statusRequest) {
        print("Email: ");
        print(email.text);
        CoolAlert.show(
            backgroundColor: AppColor.primaryColor,
            context: Get.overlayContext!,
            type: CoolAlertType.info,
            confirmBtnColor: AppColor.primaryColor,
            text: "Server Failure $response",
            onConfirmBtnTap: () {
              statusRequest = StatusRequest.serverFailure;
            });
        statusRequest = StatusRequest.serverFailure;
      } else {
        print("Not Valid");
      }
      update();
    }
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
    await Future.delayed(const Duration(seconds: 1));
    Get.offNamed(AppRoutes.login);
  }

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

  @override
  toSignUp() {
    Get.toNamed(AppRoutes.signUp);
  }

  @override
  ForgotPassword() {
    Get.toNamed(AppRoutes.forgotPassword);
  }
}
