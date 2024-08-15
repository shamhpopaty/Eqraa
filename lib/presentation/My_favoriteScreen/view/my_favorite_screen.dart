import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/localization/changelocal.dart';
import '../../../linkapi.dart';
import '../../../widgets/auth/custom_text_form.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../description_books/view/desc_books.dart';
import '../controller/my_favorite_controller.dart';

class MyFavorite extends StatelessWidget {
  final FavoriteScreenControllerImp favoritecontroller =
  Get.put(FavoriteScreenControllerImp());
   final String category;

   MyFavorite({super.key, required this.category});

  DateTime? selectedTime = DateTime.now();
  var isFavorate = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarHome(),
      drawer: Drawer(

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
                  favoritecontroller.searchQuery.value = val;
                },
              ),
            ),
            GetBuilder<FavoriteScreenControllerImp>(builder: (controller) {
              LocaleController localController =
              Get.put(LocaleController());
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
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            DescriptionBooks(
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
                            "${AppLink.server}/${controller.filteredBooks[i].
                            cover!}",
                            fit: BoxFit.cover,
                            errorBuilder: (context, error,
                                stackTrace) {
                              return Image.asset(
                                  AppImageAssets.camera,
                                  fit: BoxFit.cover);
                            },
                          ),
                          
                          height: 75,)
                          :SizedBox(
                              child:Text(favoritecontroller.filteredBooks[i].title ?? ''),
                                height: 15,),
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
  }}