import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/localization/changelocal.dart';
import '../../widgets/auth/custom_text_form.dart';
import '../booksScreen/view/books_screen.dart';

import '../send_requestsScreen/screens/send_requests.dart';
import 'home_controller.dart';

final Map<String, String> categoryTranslations = {
  "165": "Religious",
  "166": "History",
  "167": "Drama",
  "168": "Scientific",
  "169": "Cooking",
  "171": "Philosophy",
  "172": "Horror",
  "174": "Fantasy",
};
List<Map<String, String>> Category = [
  {"CategoryName": "165".tr, "EnglishName": categoryTranslations["165"]!},
  {"CategoryName": "166".tr, "EnglishName": categoryTranslations["166"]!},
  {"CategoryName": "174".tr, "EnglishName": categoryTranslations["174"]!},
  {"CategoryName": "167".tr, "EnglishName": categoryTranslations["167"]!},
  {"CategoryName": "168".tr, "EnglishName": categoryTranslations["168"]!},
  {"CategoryName": "169".tr, "EnglishName": categoryTranslations["169"]!},
  {"CategoryName": "171".tr, "EnglishName": categoryTranslations["171"]!},
  {"CategoryName": "172".tr, "EnglishName": categoryTranslations["172"]!},
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
      backgroundColor:
          (!localController.isDark) ? AppColor.white : AppColor.black,

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              //   child: AuthTextFormField(
              //     hintText: "148".tr,
              //     iconPrefix: Icons.search,
              //     textBox: '',
              //   ),
              // ),
              child: GridView.builder(
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
                      String selectedCategory = Category[i]["EnglishName"]!;
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
                        color: (!localController.isDark)
                            ? AppColor.fourthColor
                            : AppColor.primaryColorDark,
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
                          Category[i]["CategoryName"]!,
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
            ),
          ],
        ),
      ),
    );
  }
}
