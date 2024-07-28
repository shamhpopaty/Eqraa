import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../presentation/friendScreen/controller/friend_controller.dart';

class FriendsComponent extends StatefulWidget {
  final String userName;
  final int userId;

  const FriendsComponent({
    Key? key,
    required this.userName,
    required this.userId,
  }) : super(key: key);

  @override
  State<FriendsComponent> createState() => _FriendsComponentState();
}

class _FriendsComponentState extends State<FriendsComponent> {
  final FriendsController controller = Get.find();

  bool isFriend = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
      ),
      title: Text(widget.userName),
      trailing: MaterialButton(
        onPressed: () {
          if (isFriend) {
            controller.sendFriendRequest(widget.userId);
          }
          setState(() {
            isFriend = !isFriend;
          });
        },
        color: isFriend ? Colors.blue : Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isFriend ? 'Add Friend' : 'Unfriend',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            SizedBox(width: 5),
            Icon(
              isFriend ? Icons.person_add : Icons.person_remove,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
