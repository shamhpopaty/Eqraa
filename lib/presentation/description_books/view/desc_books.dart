import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../booksScreen/model/books_model.dart';
import '../../contact_us/contact_us.dart';
import '../../recieved_requestScreen/screen/recieved_request.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../controller/desc_books_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../models/book_model.dart';

class DescriptionBooks extends StatelessWidget {
  final Book book;

  DescriptionBooks({required this.book, super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DescriptionBooksControllerImp());
    return GetBuilder<DescriptionBooksControllerImp>(
        builder: (controller) {
          return Scaffold(
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
                      decoration:const BoxDecoration(
                        color: AppColor.primaryColor,
                      ),
                      child: Column(children: [
                        const CircleAvatar(backgroundImage: AssetImage(AppImageAssets.profileimage),),
                        const SizedBox(height: 20,),
                        Text("${controller.myServices.sharedPreferences.getString("username")}"),

                      ],)
                  ),
                  // ListTile(
                  //   title: Text( "144".tr),
                  //   onTap: () {
                  //   },
                  // ),
                  DropDownList(),
                  DropDownList(isThemeApp:true),
                  // ListTile(
                  //   title: Text("145".tr),
                  //   onTap: () {
                  //   },
                  // ),
                  ListTile(
                    title: Text( "146".tr),
                    onTap: () {
                      Get.to(()=>RecievedRequests());
                    },
                  ),
                  ListTile(
                    title: Text( "160".tr),
                    onTap: () {
                      Get.to(()=>Request());
                    },
                  ),
                  ListTile(
                    title: Text( "147".tr),
                    onTap: () {
                      Get.to(()=>Contact_Us());
                    },
                  ),
                  ListTile(
                    title: Text( "56".tr),
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
                    child:  book.cover != null
                        ? Image.network(
                      book.cover!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset('assets/images/camera.jpg', fit: BoxFit.cover);
                      },
                    )
                        : Image.asset('assets/images/camera.jpg', fit: BoxFit.cover),
                  ),
                  SizedBox(height: 20,),
                  Text("اسم الكتاب: ${book.title}"),
                  SizedBox(height: 5,),
                  Text("اسم الكاتب: ${book.author}"),
                  SizedBox(height: 25,),
                  Text("الوصف :",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),),
                  Text(book.description ?? ''),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),));
                  },
                    color: AppColor.secondColor,
                    child: Text("Open Book",
                      style: TextStyle(
                          fontSize: 20
                      ),),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class BookDetailScreen extends StatefulWidget {
  final Book book;

  BookDetailScreen({required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    fromAsset(widget.book.path ?? '', 'temp.pdf').then((f) {
      setState(() {
        localPath = f.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String filename) async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      throw Exception("Error copying asset to local storage: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title ?? ''),
      ),
      body:
      localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
