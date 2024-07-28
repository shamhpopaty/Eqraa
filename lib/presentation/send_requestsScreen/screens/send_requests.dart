import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../widgets/friends_requests/send_request_widget.dart';
import '../controller/send_requests_controller.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final SentFriendRequestsController controller = Get.put(SentFriendRequestsController());

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
                    'Requests',
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
              } else if (controller.sentFriendRequests.isEmpty) {
                return Center(child: Text('No friend requests sent'));
              } else {
                return Expanded(
                  child: ListView.separated(
                    itemCount: controller.sentFriendRequests.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(color: Colors.grey);
                    },
                    itemBuilder: (context, index) {
                      final request = controller.sentFriendRequests[index];
                      return FutureBuilder<String?>(
                        future: controller.fetchUserName(request.friendId!),
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
                            return RequestComponent(
                              userName: userName,
                              onCancel: () {
                                controller.cancelFriendRequest(request.friendId!, index);
                              },
                            );
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

class RequestComponent extends StatelessWidget {
  final String userName;
  final VoidCallback onCancel;

  const RequestComponent({
    Key? key,
    required this.userName,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(userName),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/placeholder.png'), // Add an appropriate image asset
      ),
      trailing: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: onCancel,
      ),
    );
  }
}
