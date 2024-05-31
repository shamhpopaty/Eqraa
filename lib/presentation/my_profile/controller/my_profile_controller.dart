import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/services/services.dart';
import 'package:eqraa/presentation/My_Profile/view/my_profile.dart';
import 'package:eqraa/widgets/custom_editing_profile.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../core/class/status_request.dart';
import '../../../routes.dart';

abstract class MyProfileController extends GetxController {
  MyProfile();
EditProfile();
}
class MyProfileControllerImp extends MyProfileController {
  String? username;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.none;
  @override
  void onInit() {
    // getData();
    username= myServices.sharedPreferences.getString("username");

    super.onInit();
  }
  @override
  EditProfile() {
    Get.toNamed(AppRoutes.editigprofile);
  }

  @override
  MyProfile() {
    Get.toNamed(AppRoutes.myprofile);
  }
}
