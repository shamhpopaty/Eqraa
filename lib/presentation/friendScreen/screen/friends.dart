import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../widgets/friends_requests/friends_widget.dart';

class Friends extends StatefulWidget {
  const Friends({super.key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
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
                      // color: MyColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.grey,
                  );
                },
                itemBuilder: (context, index) {
                  return FriendsComponent();
                  // return InkWell(
                  //   onTap: (){

                  //   },
                  //   child: Row(
                  //     children: [
                  //       CircleAvatar(
                  //         backgroundImage: AssetImage('assets/𝑩𝒂𝒋𝒊✩.jpg'),
                  //       ),

                  //     ],
                  //   ),
                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
