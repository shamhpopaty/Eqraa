import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/auth/custom_text_form.dart';
import '../booksScreen/view/books_screen.dart';
import 'home_controller.dart';

List Category=[
  {"CategoryName": "Religious"},
  {"CategoryName": "Health"},
  {"CategoryName": "Cooking"},
  {"CategoryName": "Scientific"},
  {"CategoryName": "History"},
  {"CategoryName": "Philisophy"},
];
class Classification extends StatefulWidget {
  const Classification({super.key});
  @override
  State<Classification> createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: AuthTextFormField(
                hintText: "148".tr,
                iconPrefix: Icons.search,
                textBox: '',
              ),
            ),
             GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
              ),
              itemCount: Category.length,
              itemBuilder: (context,  i) {
                return GestureDetector(
                  onTap: () {
                    Get.to(Books_Screen());
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    margin: EdgeInsets.only(
                        right: 10, left: 10, bottom: 10, top: 15),
                    decoration: BoxDecoration(
                      color: AppColor.fourthColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Text(
                        Category[i]["CategoryName"],                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
