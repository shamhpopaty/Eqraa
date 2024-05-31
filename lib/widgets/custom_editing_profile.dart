import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/widgets/custom_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/constant/color.dart';
import 'custom_profile.dart';

class EditProfile extends StatelessWidget {
  //final LinkController linkController = Get.put(LinkController());
  //final BioController bioController = Get.put(BioController());

  final TextEditingController textController = TextEditingController();
  final TextEditingController textControllerbio = TextEditingController();
  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child:Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 115,width: 115,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(AppImageAssets.profileimage),
                      ),
                      Positioned(
                        right: -12,
                        bottom: 0,
                        child:SizedBox(
                          height: 46,width: 46,
                          child: MaterialButton(onPressed: () {  },
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),
                                side: BorderSide(color: Colors.white)),
                            child: GestureDetector(child: CircleAvatar(backgroundImage:AssetImage(AppImageAssets.camera),)),
                          ) ,
                        ),),

                    ],
                  ),
                ),
            SizedBox(
              height: 50,
            ),
            Container(
            //padding: EdgeInsets.all(16),
            //margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
            color: AppColor.secondColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            hintTextDirection: TextDirection.rtl,
                            hintText: 'اضغط لتعديل رابط التواصل',
                            hintStyle: TextStyle(color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                  ),
                  //SizedBox(width: 5),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
                FacebookLinkWidget(),

          ],
        ),
        ),
        ),
      ),
    );
  }
}


class FacebookLinkWidget extends StatelessWidget {
  final LinkController linkController = Get.put(LinkController());

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Facebook Link'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your Facebook link',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                linkController.updateLink(textEditingController.text);
              },
              child: Text('Save Link'),
            ),
            SizedBox(height: 20),
            Obx(() {
              return Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Saved Link: ${linkController.facebookLink.value}',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}


class LinkController extends GetxController {
  var facebookLink = ''.obs;

  void updateLink(String link) {
    facebookLink.value = link;
  }
}

/*Container(
decoration: BoxDecoration(
color: AppColor.secondColor,
borderRadius: BorderRadius.circular(20),
),
child: SingleChildScrollView(
child: Column(
children: [
Padding(
padding: const EdgeInsets.all(8),
child:
TextField(
controller: textControllerbio,
decoration: InputDecoration(
hintTextDirection: TextDirection.rtl,
hintText: 'اضغط لتعديل السيرة الذاتية',
hintStyle: TextStyle(color: Colors.white,
),
border: InputBorder.none,
),
style: TextStyle(color: Colors.white),
),

),
//SizedBox(width: 5),
],
),
),
),*/


