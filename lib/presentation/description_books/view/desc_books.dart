import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/presentation/notesScreen/view/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';  // استيراد مكتبة لتقييم النجوم
import '../../../core/constant/color.dart';
import '../../../core/functions/logout.dart';
import '../../../linkapi.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../booksScreen/model/books_model.dart';
import '../../contact_us/view/contact_us.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../../show_book/view/show_book.dart';
import '../controller/desc_books_controller.dart';

class DescriptionBooks extends StatelessWidget {
  final Book book;
  final int endTimeMillisecond;

  DescriptionBooks(
      {required this.book, super.key, required this.endTimeMillisecond});

  @override
  Widget build(BuildContext context) {
    // استخدام الـ controller
    Get.put(DescriptionBooksControllerImp());

    return GetBuilder<DescriptionBooksControllerImp>(builder: (controller) {
      return Scaffold(
        backgroundColor: (!localController.isDark) ? AppColor.white : AppColor.black,
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_forward)),
          ],
        ),
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 60,
                  right: 60,
                ),
                child: book.cover != null
                    ? Image.network(
                  "${AppLink.baseServer}/storage/${book.cover!}",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/camera.jpg',
                        fit: BoxFit.cover);
                  },
                )
                    : Image.asset('assets/images/camera.jpg',
                    fit: BoxFit.cover),
              ),
              SizedBox(
                height: 20,
              ),
              Text("181: ${book.title}".tr),
              SizedBox(
                height: 5,
              ),
              Text("182: ${book.author}".tr),
              SizedBox(
                height: 25,
              ),
              Text(
                "183".tr,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(book.description ?? ''),
              SizedBox(
                height: 20,
              ),
              Text(book.description ?? ''),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  Get.to(() => BookDetailScreen(
                    book: book,
                    endTimeMillisecond: endTimeMillisecond,
                  ));
                },
                color:(!localController.isDark)? AppColor.secondColor:AppColor.secondColorDark,
                child: Text(
                  "184".tr,
                  style: TextStyle(fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // زر تقييم الكتاب
              MaterialButton(
                onPressed: () {
                  _showRatingDialog(context, controller);
                },
                color: AppColor.primaryColor,
                child: Text(
                  "Rate Book",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // دالة لعرض حوار تقييم النجوم
  void _showRatingDialog(BuildContext context, DescriptionBooksControllerImp controller) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Rate this book"),
          content: RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              controller.rating = rating.toInt();
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.rateBook();
                Navigator.pop(context);
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
