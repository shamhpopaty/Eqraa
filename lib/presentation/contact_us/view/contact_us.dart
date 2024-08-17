import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

import '../contact_us_controller/contact_us_controller.dart';

final Uri _url = Uri.parse('https://github.com/Kheder-YSF/Eqraa');

class Contact_Us extends StatefulWidget {
  const Contact_Us({super.key});

  @override
  State<Contact_Us> createState() => _Contact_UsState();
}

class _Contact_UsState extends State<Contact_Us> {
  TextEditingController complaints = TextEditingController();
  ContactUsController complaintscontroller = Get.put(ContactUsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:   Text(
        "163".tr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          //fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),),
      body: Column(
mainAxisAlignment: MainAxisAlignment.center,
              children: [


                Padding(
            padding: const EdgeInsets.only(top: 2.0, right: 5, left: 5),
                  child: Center(
                    child: Column(
                      children: [
                        Text("161".tr,
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                        InkWell(child: Text("162".tr,
                        style: TextStyle(
                          color: AppColor.secondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),),
                        onTap: (){
                          showMyDialog(context);

                        },
                        ),
                      ],
                    ),
                  ),
                )
            ],
            ),

      );
  }
  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("178".tr),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text('This is a simple dialog.'),
                // Text('Would you like to continue?'),
                TextField(
                  controller:
                  complaints, ///////  هذا بجبلي قيم النص وما شابه
                  keyboardType: TextInputType.multiline,
                  maxLines: null, // Allows the text field to expand as needed
                  decoration:  InputDecoration(
                    hintText: '179'.tr,
                    border:
                    OutlineInputBorder(), ////// تعديل شكل المربع تبع الملاحظات
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('180'.tr),
              onPressed: () {
                Navigator.of(context).pop(); // Closes the dialog
              },
            ),
            TextButton(
              child:  Text('33'.tr),
              onPressed: () async {
                ContactUsController complaintscontroller =
                Get.put(ContactUsController());

                await complaintscontroller.addComplaints(complaints.text);

                Navigator.of(context).pop();
                complaints.clear();
                // print(noteController.text);
                // print(currentPage);
                // print(widget.book.title!);
              },
            ),
          ],
        );
      },
    );
  }

}
