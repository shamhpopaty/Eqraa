import 'dart:convert';

import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/class/handlingdataview.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/presentation/notesScreen/view/notes_screen.dart';
import 'package:eqraa/presentation/show_book/view/show_book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../core/functions/logout.dart';
import '../../../core/localization/changelocal.dart';
import '../../../linkapi.dart';
import '../../../widgets/auth/custom_text_form.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../My_favoriteScreen/controller/my_favorite_controller.dart';
import '../../My_favoriteScreen/view/my_favorite_screen.dart';
import '../../contact_us/contact_us.dart';
import '../../description_books/view/desc_books.dart';
import '../../my_profile/view/editing_profile.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../controller/books_screen_controller.dart';


class BooksScreen extends StatefulWidget {
  final String category;
  final FavoriteScreenControllerImp favoriteController = Get.put(FavoriteScreenControllerImp());

  BooksScreen({required this.category});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  var isFavorate = [];
  @override
  Widget build(BuildContext context) {
    final BooksScreenControllerImp controller =
    Get.put(BooksScreenControllerImp(widget.category));
    DateTime? selectedTime = DateTime.now();

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
                      backgroundImage:
                      AssetImage(AppImageAssets.profileimage),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Text("${controller.myServices.sharedPreferences.getString("username")??"Kheder Youssef"}"),
                  ],
                )),
            DropDownList(),
            DropDownList(isThemeApp: true),
            ListTile(
              title: Text("146".tr),
              onTap: () {
                Get.to(() => RecievedRequests());
              },
            ),
            ListTile(
              title: Text("160".tr),
              onTap: () {
                Get.to(() => Request());
              },
            ),
            ListTile(
              title: Text("173".tr),
              onTap: () {
                Get.to(() => NotesScreen());
              },
            ),
            ListTile(
              title: Text("147".tr),
              onTap: () {
                Get.to(() => Contact_Us());
              },
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
                hintText: "بحث بالعنوان",
                iconPrefix: Icons.search,
                textBox: '',
                onChanged: (val) {
                  controller.searchQuery.value = val;
                },
              ),
            ),
            GetBuilder<BooksScreenControllerImp>(builder: (controller) {
              LocaleController localController =
              Get.put(LocaleController());
              if (controller.filteredBooks.isNotEmpty) {
                for (int i = 0; i < controller.filteredBooks.length; i++) {
                  isFavorate.add(false);
                }
              }
              return HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: controller.filteredBooks.length,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => DescriptionBooks(
                          book: controller.filteredBooks[i],
                          endTimeMillisecond: selectedTime != null
                              ? selectedTime!.millisecondsSinceEpoch
                              : -1,
                        ));
                      },
                      child: Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10, top: 15),
                        decoration: BoxDecoration(
                          color: (!localController.isDark)
                              ? AppColor.fourthColor
                              : AppColor.primaryColorDark,
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
                            controller.filteredBooks[i].cover != null
                                ? SizedBox(
                              child: Image.network(
                                "${AppLink.server}/${controller.filteredBooks[i].cover!}",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error,
                                    stackTrace) {
                                  return Image.asset(
                                      AppImageAssets.camera,
                                      fit: BoxFit.cover);
                                },
                              ),
                              height: 75,
                            )
                                : SizedBox(
                              child: Image.asset(
                                  AppImageAssets.camera,
                                  fit: BoxFit.cover),
                              height: 10,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(controller.filteredBooks[i].title ?? ''),
                            const SizedBox(
                              height: 15,
                            ),
                    Row(
                    children: [
                    IconButton(
                    onPressed: () async {
                    TimeOfDay timeOfDay = await showDialog(
                    context: context,
                    builder: (context) {
                    return TimePickerDialog(
                    initialTime: TimeOfDay.fromDateTime(
                    DateTime.now()),
                    confirmText: "ok",
                    cancelText: "cancel",
                    );
                    },
                    );

                    if (timeOfDay != null) {

                    DateTime now = DateTime.now();
                    selectedTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    timeOfDay.hour,
                    timeOfDay.minute,
                    );
                    } else {
                    // If no time is selected, set selectedTime to null or -1
                    selectedTime = null; // or another placeholder
                    }
                    },
                    icon: Icon(Icons.alarm)),
                      IconButton(
                        icon: Icon(
                          isFavorate[i] ? Icons.favorite : Icons.favorite_border,
                          color: isFavorate[i] ? Colors.red : Colors.grey,
                        ),
                        onPressed: () async {
                          setState(() {
                            isFavorate[i] = !isFavorate[i];
                          });

                          if (isFavorate[i]) { // فقط إذا تحولت الأيقونة إلى حمراء
                            FavoriteScreenControllerImp favoriteScreenController = Get.put(FavoriteScreenControllerImp());

                            int? bookId = controller.books[i].id; // الحصول على الـ id الصحيح من الكائن Book

                            await favoriteScreenController.addFavoriteBook(bookId!); // مرر الـ id هنا

                            Get.snackbar('Success', 'تمت اضافة الكتاب بنجاح');
                          } else {
                            Get.snackbar('Success', "تم ازالة الكتاب");
                          }
                        },
                      ),


                    ],
                    ),

                    ],
                    ),
                    ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}