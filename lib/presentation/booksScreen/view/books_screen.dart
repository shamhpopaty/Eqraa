import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/auth/custom_text_form.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../description_books/view/desc_books.dart';
import '../controller/books_screen_controller.dart';

List Books=[
  {"NameBook": "shmail"},
  {"NameBook": "sera"},
  {"NameBook": "hart"},
  {"NameBook": "doaa"}
];

class Books_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(BooksScreenControllerImp());
    return GetBuilder<BooksScreenControllerImp>(
        builder: (controller)
    {
      return SafeArea(
        child: Scaffold(
          appBar: const CustomAppBarHome(),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColor.primaryColor,
                    ),
                    child: Column(children: [
                      const CircleAvatar(backgroundImage: AssetImage(
                          AppImageAssets.profileimage),),
                      const SizedBox(height: 20,),
                      Text("${controller.myServices.sharedPreferences.getString(
                          "username")}"),

                    ],)
                ),
                // ListTile(
                //   title: Text("144".tr),
                //   onTap: () {},
                // ),

                DropDownList(),
                DropDownList(isThemeApp:true),
                // ListTile(
                //   title: Text("145".tr),
                //   onTap: () {},
                // ),
                ListTile(
                  title: Text("146".tr),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("147".tr),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("56".tr),
                  onTap: () {
                    logOut();
                  },
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8, top: 8, bottom: 8),
                  child: AuthTextFormField(
                    hintText: "148".tr,
                    iconPrefix: Icons.search,
                    textBox: '',
                  ),
                ),

                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: Books.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() =>  Description_Books());
                      },
                      child: Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10, top: 15),
                        decoration: BoxDecoration(
                          color: AppColor.fourthColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 3,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Image(image: AssetImage(AppImageAssets.book),
                              fit: BoxFit.cover,),
                            const SizedBox(height: 15,),
                            Text(Books[i]["NameBook"]),

                          ],
                        ),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
      );
    }
    );
  }
}
