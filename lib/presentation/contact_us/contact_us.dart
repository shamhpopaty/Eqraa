import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/Kheder-YSF/Eqraa');

class Contact_Us extends StatefulWidget {
  const Contact_Us({super.key});

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
              children: [
        Expanded(
          flex: 0,
          child: Container(
            color: AppColor.primaryColor,
            child:
            Row(
                children: [
                IconButton(
                onPressed: () {
        Get.back();
        },
          icon: Icon(Icons.arrow_back),
        ),
        SizedBox(width: 250,),
            Text(
              "163".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                //fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
        ],
          ),
        ),
      ),
                SizedBox(height: 200,),
                Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 50, left: 30),
                  child: Center(
                    child: Column(
                      children: [
                        Text("161".tr,
                        style: TextStyle(
                          fontSize: 30,
                        ),),
                        InkWell(child: Text("162".tr,
                        style: TextStyle(
                          color: AppColor.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),),
                        onTap: _launchUrl,
                        ),
                      ],
                    ),
                  ),
                )
            ],
            ),

      );
  }
}
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}