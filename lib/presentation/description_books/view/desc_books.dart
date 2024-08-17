import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/presentation/notesScreen/view/notes_screen.dart';
import 'package:flutter/material.dart';
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
    Get.put(DescriptionBooksControllerImp());
    return GetBuilder<DescriptionBooksControllerImp>(builder: (controller) {
      return Scaffold(
        backgroundColor:
        (!localController.isDark) ? AppColor.white : AppColor.black,
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
              MaterialButton(
                onPressed: () {
                  Get.to(() => BookDetailScreen(
                        book: book,
                        endTimeMillisecond: endTimeMillisecond,
                      ));
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => BookDetailScreen(book: book),
                  //     ));
                },
                color:(!localController.isDark)? AppColor.secondColor:AppColor.secondColorDark,
                child: Text(
                  "184".tr,
                  style: TextStyle(fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

// class BookDetailScreen extends StatefulWidget {
//   final Book book;

//   BookDetailScreen({required this.book});

//   @override
//   _BookDetailScreenState createState() => _BookDetailScreenState();
// }

// class _BookDetailScreenState extends State<BookDetailScreen> {
//   String? localPath;

//   @override
//   void initState() {
//     super.initState();
//     fromAsset(widget.book.path ?? '', 'temp.pdf').then((f) {
//       setState(() {
//         localPath = f.path;
//       });
//     });
//   }

//   Future<File> fromAsset(String asset, String filename) async {
//     try {
//       var dir = await getApplicationDocumentsDirectory();
//       var file = File("${dir.path}/$filename");
//       var data = await rootBundle.load(asset);
//       var bytes = data.buffer.asUint8List();
//       await file.writeAsBytes(bytes, flush: true);
//       return file;
//     } catch (e) {
//       throw Exception("Error copying asset to local storage: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.book.title ?? ''),
//       ),
//       body: localPath != null
//           ? PDFView(
//               filePath: localPath,
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
