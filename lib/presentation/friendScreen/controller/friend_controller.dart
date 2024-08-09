import 'package:eqraa/data/token_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/class/status_request.dart';
import '../model/friends_model.dart';

class FriendsController extends GetxController {
  var friendsList = <User>[].obs;
  var isLoading = false.obs;
  var statusRequest = StatusRequest.loading.obs;

  final String token = '14|Q9bUYgsFAbqoIXiVnjNeyygoNZbU93etJ3NBYS3Sc2c40fc2';

  @override
  void onInit() {
    fetchFriends();
    super.onInit();
  }

  Future<void> fetchFriends() async {
    statusRequest(StatusRequest.loading);
    try {
      String accessToken = await TokenManager().accessToken;
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/users?search'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        friendsList.value = body.map((dynamic item) => User.fromJson(item)).toList();
        statusRequest(StatusRequest.success);
      } else {
        statusRequest(StatusRequest.failure);
      }
    } catch (e) {
      statusRequest(StatusRequest.failure);
      print(e);
    }
  }

  Future<void> sendFriendRequest(int userId) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.247.175:8000/api/users/friendship/send-friend-request'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': userId,
        }),
      );
print(userId);
print(response.statusCode);
print(response.body);
      if (response.statusCode == 200||response.statusCode == 201) {
        var body = json.decode(response.body);
        Get.snackbar('Success', body['message']);
      } else if (response.statusCode == 400){
        var body = json.decode(response.body);
        Get.snackbar('Error', body['message']);

      }else {
        Get.snackbar('Error', 'Failed to send friend request');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while sending friend request');
    }
  }
}
