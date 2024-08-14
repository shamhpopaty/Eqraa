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
import '../../../widgets/auth/custom_text_form.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../My_favoriteScreen/controller/my_favorite_controller.dart';
import '../../My_favoriteScreen/view/my_favorite_screen.dart';
import '../../contact_us/contact_us.dart';
import '../../description_books/view/desc_books.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../controller/books_screen_controller.dart';


class BooksScreen extends StatefulWidget {
  final String category;
  final FavoriteController favoriteController = Get.put(FavoriteController());

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
    DateTime selectedTime = DateTime.now();
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
            // ListTile(
            //   title: Text( "144".tr),
            //   onTap: () {
            //   },
            // ),
            DropDownList(),
            DropDownList(isThemeApp: true),
            // ListTile(
            //   title: Text("145".tr),
            //   onTap: () {
            //   },
            // ),
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
                hintText: "148".tr,
                iconPrefix: Icons.search,
                textBox: '',
              ),
            ),
            GetBuilder<BooksScreenControllerImp>(builder: (controller) {
              LocaleController localController = Get.put(LocaleController());
              if(controller.books.isNotEmpty){

                for(int i=0;i<controller.books.length;i++){

                  isFavorate.add(false);
                }
              }
              return HandlingDataView(
                statusRequest: controller.statusRequest,
                widget: GridView.builder(
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
                        // Get.to(
                        //   () => BookListScreen(
                        //     endTimeMillisecond:
                        //         selectedTime.millisecondsSinceEpoch,
                        //   ),
                        // );
                        Get.to(() => DescriptionBooks(
                              book: controller.books[i],
                              endTimeMillisecond:
                                  selectedTime.millisecondsSinceEpoch,
                            ));
                      },
                      child: Container(
                        height: 100,
                        width: 200,
                        margin: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10, top: 15),
                        decoration: BoxDecoration(
                          // (condition)?(true):(false)
                          color:(!localController.isDark)? AppColor.fourthColor:AppColor.primaryColorDark,
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
                            // Image.asset(
                            //   'assets/images/camera.jpg',
                            //   fit: BoxFit.cover,
                            // ),
                            controller.books[i].cover != null
                                ? SizedBox(
                                    child: Image.network(
                                      controller.books[i].cover!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'assets/images/camera.jpg',
                                            fit: BoxFit.cover);
                                      },
                                    ),
                                    height: 75,
                                  )
                                : SizedBox(
                                    child: Image.asset(
                                        'assets/images/camera.jpg',
                                        fit: BoxFit.cover),
                                    height: 10,
                                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(controller.books[i].title ?? ''),
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
                                      DateTime now = DateTime.now();
                                      selectedTime = DateTime(
                                        now.year,
                                        now.month,
                                        now.day,
                                        timeOfDay.hour,
                                        timeOfDay.minute,
                                      );
                                    },
                                    icon: Icon(Icons.alarm)),
                                IconButton(
                                  icon: Icon(
                                    isFavorate[i] ? Icons.favorite : Icons.favorite_border,
                                    color: isFavorate[i] ? Colors.red : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isFavorate[i] = !isFavorate[i];
                                    });
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
