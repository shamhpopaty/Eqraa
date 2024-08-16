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
import '../../contact_us/view/contact_us.dart';
import '../../description_books/view/desc_books.dart';
import '../../my_profile/view/editing_profile.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../controller/books_screen_controller.dart';
import 'book_card.dart';

class BooksScreen extends StatefulWidget {
  final String category;

  BooksScreen({required this.category});

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  var isFavorate = [];

  @override
  Widget build(BuildContext context) {
    final FavoriteScreenControllerImp favoriteController =
        Get.put(FavoriteScreenControllerImp());
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 8.0, right: 8, top: 8, bottom: 8),
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
              LocaleController localController = Get.put(LocaleController());
              if (controller.filteredBooks.isNotEmpty) {
                for (int i = 0; i < controller.filteredBooks.length; i++) {
                  isFavorate.add(false);
                }
              }
              return HandlingDataView(
                statusRequest: controller.statusRequest,
                text: "175".tr,
                onOffline: () {
                  controller.fetchBooks();
                },
                widget: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 5.0,
                    crossAxisSpacing: 5.0,
                  ),
                  itemCount: controller.filteredBooks.length,
                  itemBuilder: (context, i) {
                    return // Inside your widget build method
                        Obx(() {
                      final book = controller.filteredBooks[i];
                      final isFavorite =
                          favoriteController.isBookFavorite(book.id!);

                      return HandlingDataView(
                        statusRequest: favoriteController.statusRequest.value,
                        imageHeight: 100,
                        widget: BookCard(
                          onTap: () {
                            Get.to(() => DescriptionBooks(
                                book: controller.books[i],
                                endTimeMillisecond:
                                    selectedTime!.millisecondsSinceEpoch));
                          },
                          book: book,
                          isFavorite: isFavorite,
                          onFavoriteToggle: () async {
                            await favoriteController.toggleFavoriteBook(book);
                          },
                          selectedTime: selectedTime,
                          onTimePicked: (pickedTime) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          },
                          isDark: false,
                        ),
                      );
                    });
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
