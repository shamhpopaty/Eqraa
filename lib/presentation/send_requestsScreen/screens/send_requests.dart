import 'package:eqraa/core/app_export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../widgets/friends_requests/send_request_widget.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, right: 30, left: 30),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {
                  Get.back();
                }, icon: Icon(Icons.arrow_back)),
                Expanded(
                  child: Text(
                    'Requests',
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
                  return RequestComponent();
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
