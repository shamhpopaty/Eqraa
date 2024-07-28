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

class BooksScreen extends StatelessWidget {
  final String category;

  BooksScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    final BooksScreenControllerImp controller = Get.put(BooksScreenControllerImp(category));

    return Scaffold(
      appBar: const CustomAppBarHome(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(AppImageAssets.profileimage),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text("${controller.myServices.sharedPreferences.getString("username")}"),
                  ],
                )),
            DropDownList(),
            DropDownList(isThemeApp: true),
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
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
                  itemCount: controller.books.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DescriptionBooks(book: controller.books[i]));
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
                            controller.books[i].cover != null
                                ? Image.network(
                              controller.books[i].cover!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/camera.jpg', fit: BoxFit.cover);
                              },
                            )
                                : Image.asset('assets/images/camera.jpg', fit: BoxFit.cover),
                            const SizedBox(height: 15,),
                            Text(controller.books[i].title ?? ''),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
