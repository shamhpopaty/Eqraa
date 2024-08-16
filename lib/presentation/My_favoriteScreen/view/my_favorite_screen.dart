import 'package:eqraa/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../core/class/status_request.dart';
import '../../../widgets/Custom_Favorite_Book.dart';
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
  @override
  Widget build(BuildContext context) {
    final FavoriteScreenControllerImp favoriteScreenControllerImp = Get.put(FavoriteScreenControllerImp());

    return Scaffold(
      backgroundColor: (!localController.isDark) ? AppColor.white : AppColor.black,
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
              GetBuilder<FavoriteScreenControllerImp>(builder: (favoriteScreenControllerImp) {
                LocaleController localController = Get.put(LocaleController());
                return HandlingDataView(
                  statusRequest: favoriteScreenControllerImp.statusRequest,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // لجعل القائمة تعمل بسلاسة داخل ScrollView
                    itemCount: favoriteScreenControllerImp.favoriteBooks.length,
                    itemBuilder: (context, index) {
                      final fav= favoriteScreenControllerImp.favoriteBooks[index];

                      return Column(
                        children: [
                          Favorite_Item(favorites:fav,favoriteScreenControllerImp:favoriteScreenControllerImp),
                          SizedBox(height: 20,)
                        ],
                      ); // تمرير البيانات إلى الـ NoteItem
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// class MyFavoriteScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final FavoriteScreenControllerImp favoritescreencontroller = Get.find();
//     DateTime? selectedTime = DateTime.now();
//
//     return Scaffold(
//       appBar: AppBar(title: Text('My Favorite Books')),
//       body: Obx(() {
//         if (favoritescreencontroller.statusRequest.value == StatusRequest.loading) {
//           return Center(child: CircularProgressIndicator());
//         } else if (favoritescreencontroller.statusRequest.value == StatusRequest.success) {
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 10,
//               crossAxisSpacing: 10,
//             ),
//             itemCount: favoritescreencontroller.favoriteBooks.length,
//             itemBuilder: (context, i) {
//               final book = favoritescreencontroller.favoriteBooks[i];
//               return GestureDetector(
//                 onTap: () {
//                   Get.to(() => DescriptionBooks(
//                     book: favoritescreencontroller.filteredBooks[i],
//                     endTimeMillisecond: selectedTime != null
//                         ? selectedTime!.millisecondsSinceEpoch
//                         : -1,
//                   ));
//                 },
//                 child: Card(
//                   child: Column(
//                     children: [
//                       book.cover != null
//                           ? Image.network(
//                         book.cover!,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) {
//                           return Image.asset('assets/images/placeholder.png');
//                         },
//                       )
//                           : Placeholder(),
//                       SizedBox(height: 10),
//                       Text(book.title ?? 'No Title'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return Center(child: Text('Failed to load books'));
//         }
//       }),
//     );
//   }
// }

