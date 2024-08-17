import 'package:dartz/dartz.dart';
import 'package:eqraa/core/services/services.dart';
import 'package:eqraa/data/token_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/class/status_request.dart';
import '../../../linkapi.dart';
import '../model/profile_model.dart';

class MyProfileController extends GetxController {
  var userProfile = UserProfileResponse().obs;
  var statusRequest = StatusRequest.loading.obs;
 MyServices myServices=  Get.find();
  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    statusRequest(StatusRequest.loading);
    try {
      String accessToken = await TokenManager().accessToken;

      final response = await http.get(
        Uri.parse(AppLink.myprofile(id as int)),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
print(response.statusCode);
print(response.body);
      if (response.statusCode == 200) {
        userProfile.value = UserProfileResponse.fromJson(json.decode(response.body));
         // myServices.sharedPreferences.setString("username", "${userProfile.value.user?.name}");
        statusRequest(StatusRequest.success);
      } else {
        statusRequest(StatusRequest.failure);
      }
    } catch (e) {
      statusRequest(StatusRequest.failure);
      print(e);
    }
  }
}



class EditProfileController extends GetxController {
  var profile = ProfileModel(
    imageUrl: 'https://via.placeholder.com/150', // رابط الصورة الافتراضية
    bio: 'This is a default bio.',
    socialLink: 'https://sociallink.com',
  ).obs;

  void updateImage(String newImageUrl) {
    profile.update((val) {
      val?.imageUrl = newImageUrl;
    });
  }

  void updateBio(String newBio) {
    profile.update((val) {
      val?.bio = newBio;
    });
  }

  void updateSocialLink(String newSocialLink) {
    profile.update((val) {
      val?.socialLink = newSocialLink;
    });
  }
}
