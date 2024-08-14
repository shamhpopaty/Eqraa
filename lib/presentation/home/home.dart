import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/localization/changelocal.dart';
import '../../widgets/auth/custom_text_form.dart';
import '../booksScreen/view/books_screen.dart';

import '../send_requestsScreen/screens/send_requests.dart';
import 'home_controller.dart';

List Category = [
  {"CategoryName": "165".tr},
  {"CategoryName": "166".tr},
  {"CategoryName": "172".tr},
  {"CategoryName": "167".tr},
  {"CategoryName": "168".tr},
  {"CategoryName": "169".tr},
  {"CategoryName": "170".tr},
  {"CategoryName": "171".tr},

];

class Classification extends StatefulWidget {
    const Classification({key});
  @override
  State<Classification> createState() => _ClassificationState();
}

class _ClassificationState extends State<Classification> {
  final HomeController homeController = Get.put(HomeController());
  LocaleController localController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomAppBarHome(),
backgroundColor: (!localController.isDark)? AppColor.white:AppColor.black,

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
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    String selectedCategory = Category[i]["CategoryName"];
                    Get.to(() => BooksScreen(category: selectedCategory));
                    // Get.to(() =>
                    // DescriptionBooks(book: selectedCategory));
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    margin: EdgeInsets.only(
                        right: 10, left: 10, bottom: 10, top: 15),
                    decoration: BoxDecoration(
                      color:(!localController.isDark)? AppColor.fourthColor:AppColor.primaryColorDark,
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
                        Category[i]["CategoryName"],
                        textAlign: TextAlign.center,
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
