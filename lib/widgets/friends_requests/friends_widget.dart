import 'package:flutter/material.dart';

class FriendsComponent extends StatefulWidget {
  const FriendsComponent({super.key});

  @override
  State<FriendsComponent> createState() => _FriendsComponentState();
}

class _FriendsComponentState extends State<FriendsComponent> {
  // متغيرات لحفظ حالة الزر
  bool isFriend = true;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
      ),
      title: Text('Haydy al meaaw'),
      trailing: MaterialButton(
        onPressed: () {
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
                  fontSize: 11
              ),
            ),
            SizedBox(width: 5), // مسافة صغيرة بين النص والأيقونة
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
