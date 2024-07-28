import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../widgets/friends_requests/recieved_request_widget.dart';
import '../controller/recieved_request_controller.dart';

class RecievedRequests extends StatefulWidget {
  const RecievedRequests({super.key});

  @override
  State<RecievedRequests> createState() => _RecievedRequestsState();
}

class _RecievedRequestsState extends State<RecievedRequests> {
  final FriendRequestsController controller = Get.put(FriendRequestsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 30, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Text(
                    'Recieved Requests',
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
                return Center(child: Text('Failed to load requests'));
              } else if (controller.friendRequests.isEmpty) {
                return Center(child: Text('No friend requests received'));
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.friendRequests.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey);
                    },
                    itemBuilder: (context, index) {
                      final request = controller.friendRequests[index];
                      return FutureBuilder<String?>(
                        future: controller.fetchUserName(request.userId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return ListTile(
                              title: Text('Loading...'),
                            );
                          } else if (snapshot.hasError) {
                            return ListTile(
                              title: Text('Error loading user name'),
                            );
                          } else {
                            final userName = snapshot.data ?? 'Unknown User';
                            return RecievedComponent(userName: userName);
                          }
                        },
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

class RecievedComponent extends StatelessWidget {
  final String userName;

  const RecievedComponent({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userName),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/placeholder.png'), // Add an appropriate image asset
      ),
    );
  }
}
