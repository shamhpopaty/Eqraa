import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../core/class/status_request.dart';
import '../model/sent_friend_request_model.dart';

class SentFriendRequestsController extends GetxController {
  var sentFriendRequests = <SentFriendRequest>[].obs;
  var isLoading = false.obs;
  var statusRequest = StatusRequest.loading.obs;

  final String token = '5|eEH5v9BDZ3t5lGHTi8zOc9Ga9OkMWwRBFhlrHBw392a3d872';

  @override
  void onInit() {
    fetchSentFriendRequests();
    super.onInit();
  }

  Future<void> fetchSentFriendRequests() async {
    statusRequest(StatusRequest.loading);
    try {
      final response = await http.get(
        Uri.parse('http://192.168.247.175:8000/api/users/friendship/sent-friend-requests'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        sentFriendRequests.value = body.map((dynamic item) => SentFriendRequest.fromJson(item)).toList();
        statusRequest(StatusRequest.success);
      } else {
        statusRequest(StatusRequest.failure);
      }
    } catch (e) {
      statusRequest(StatusRequest.failure);
      print(e);
    }
  }

  Future<String?> fetchUserName(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.247.175:8000/api/users/$userId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> body = json.decode(response.body);
        return User.fromJson(body['user']).name;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> cancelFriendRequest(int requestId, int index) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.247.175:8000/api/users/friendship/cancel-friend-request'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'id': requestId.toString(),
          '_method': 'delete',
        },
      );
print(response.statusCode);
print(response.body);
      if (response.statusCode == 200) {
        sentFriendRequests.removeAt(index);
        Get.snackbar('Success', 'Friend request canceled successfully');
      } else {
        Get.snackbar('Error', 'Failed to cancel friend request');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', 'An error occurred while canceling friend request');
    }
  }
}
