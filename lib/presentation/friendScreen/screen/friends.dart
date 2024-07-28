import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../controller/friend_controller.dart';
import '../../../widgets/friends_requests/friends_widget.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  final FriendsController controller = Get.put(FriendsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 30, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Text(
                    'Friends',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.statusRequest.value == StatusRequest.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.statusRequest.value == StatusRequest.failure) {
                return Center(child: Text('Failed to load friends'));
              } else if (controller.friendsList.isEmpty) {
                return Center(child: Text('No friends found'));
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.friendsList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey);
                    },
                    itemBuilder: (context, index) {
                      final friend = controller.friendsList[index];
                      return FriendsComponent(
                        userName: friend.name!,
                        userId: friend.id!,
                      );
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
