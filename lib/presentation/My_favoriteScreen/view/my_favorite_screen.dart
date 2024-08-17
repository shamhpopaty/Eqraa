import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/apptheme.dart';
import 'package:flutter/material.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../booksScreen/view/book_card.dart';
import '../../contact_us/view/contact_us.dart';
import '../../description_books/view/desc_books.dart';
import '../../notesScreen/view/notes_screen.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../controller/my_favorite_controller.dart';
import 'package:get/get.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/localization/changelocal.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  DateTime? selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final FavoriteScreenControllerImp favoriteScreenControllerImp =
        Get.put(FavoriteScreenControllerImp());

    return Scaffold(
      backgroundColor:
          (!localController.isDark) ? AppColor.white : AppColor.black,
      //appBar: const CustomAppBarHome(),
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
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<FavoriteScreenControllerImp>(
                  builder: (favoriteScreenControllerImp) {
                LocaleController localController = Get.put(LocaleController());
                return Obx(() {
                  return favoriteScreenControllerImp.favoriteBooks.isEmpty
                      ? Center(
                          child: Text(
                            "176".tr,
                            style: MyTextStyle.titleLarge,
                          ),
                        )
                      : HandlingDataView(
                          statusRequest:
                              favoriteScreenControllerImp.statusRequest.value,
                          text: "176".tr,
                          onOffline: () {
                            favoriteScreenControllerImp.fetchFavoriteBooks();
                          },
                          widget: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                            ),
                            itemCount: favoriteScreenControllerImp
                                .favoriteBooks.length,
                            itemBuilder: (context, index) {
                              final fav = favoriteScreenControllerImp
                                  .favoriteBooks[index];
                              final isFavorite = favoriteScreenControllerImp
                                  .isBookFavorite(fav.id!);

                              return BookCard(
                                onTap: () {
                                  Get.to(() => DescriptionBooks(
                                      book: fav,
                                      endTimeMillisecond: selectedTime!
                                          .millisecondsSinceEpoch));
                                },
                                book: fav,
                                isFavorite: isFavorite,
                                onFavoriteToggle: () async {
                                  await favoriteScreenControllerImp
                                      .toggleFavoriteBook(fav);
                                },
                                selectedTime: selectedTime,
                                onTimePicked: (pickedTime) {
                                  setState(() {
                                    selectedTime = pickedTime;
                                  });
                                },
                                isDark: localController.isDark,
                              );
                            },
                          ),
                        );
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
