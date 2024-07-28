import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../core/class/status_request.dart';
import '../model/friend_request_model.dart';


class FriendRequestsController extends GetxController {
  var friendRequests = <FriendRequest>[].obs;
  var isLoading = false.obs;
  var statusRequest = StatusRequest.loading.obs;

  final String token = '5|eEH5v9BDZ3t5lGHTi8zOc9Ga9OkMWwRBFhlrHBw392a3d872';

  @override
  void onInit() {
    fetchFriendRequests();
    super.onInit();
  }

  Future<void> fetchFriendRequests() async {
    statusRequest(StatusRequest.loading);
    try {
      final response = await http.get(
        Uri.parse('http://192.168.247.175:8000/api/users/friendship/received-friend-requests'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
print(response.statusCode);
print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        friendRequests.value = body.map((dynamic item) => FriendRequest.fromJson(item)).toList();

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
}
