import 'package:eqraa/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/class/status_request.dart';
import '../../../widgets/Custom_Favorite_Book.dart';
import '../../booksScreen/view/book_card.dart';
import '../../description_books/view/desc_books.dart';
import '../controller/my_favorite_controller.dart';

import 'package:eqraa/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alert_alarm.dart';
import '../../../core/localization/changelocal.dart';
import '../../../widgets/custom_note_item.dart';
import '../../../widgets/homeScreen/customappbar.dart';

class MyFavoriteScreen extends StatefulWidget {
  const MyFavoriteScreen({super.key});

  @override
  State<MyFavoriteScreen> createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  DateTime? selectedTime;

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
                  const SizedBox(height: 20),
                  // Text("${controller.myServices.sharedPreferences.getString("username")??"Kheder Youssef"}"),
                ],
              ),
            ),
            // بقية الكود الخاص بالـ Drawer
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
                  return HandlingDataView(
                    statusRequest:
                        favoriteScreenControllerImp.statusRequest.value,
                    widget: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                      ),
                      itemCount:
                          favoriteScreenControllerImp.favoriteBooks.length,
                      itemBuilder: (context, index) {
                        final fav =
                            favoriteScreenControllerImp.favoriteBooks[index];
                        final isFavorite =
                            favoriteScreenControllerImp.isBookFavorite(fav.id!);

                        return BookCard(
                          onTap: () {
                            Get.to(() => DescriptionBooks(
                                book: fav,
                                endTimeMillisecond:
                                    selectedTime!.millisecondsSinceEpoch));
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
