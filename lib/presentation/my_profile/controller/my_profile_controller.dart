import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/class/status_request.dart';
import '../model/profile_model.dart';

class MyProfileController extends GetxController {
  var userProfile = UserProfileResponse().obs;
  var statusRequest = StatusRequest.loading.obs;

  @override
  void onInit() {
    fetchUserProfile();
    super.onInit();
  }

  Future<void> fetchUserProfile() async {
    statusRequest(StatusRequest.loading);
    try {
      final response = await http.get(
        Uri.parse('http://192.168.247.175:8000/api/users/1'),
        headers: {
          'Authorization': 'Bearer 5|eEH5v9BDZ3t5lGHTi8zOc9Ga9OkMWwRBFhlrHBw392a3d872',
        },
      );
print(response.statusCode);
print(response.body);
      if (response.statusCode == 200) {
        userProfile.value = UserProfileResponse.fromJson(json.decode(response.body));
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
