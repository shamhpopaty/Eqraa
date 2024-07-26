import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../send_requestsScreen/screens/send_requests.dart';
import '../../show_book/view/show_book.dart';
import '../controller/desc_books_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class Description_Books extends StatelessWidget {
  final List<Book> books = [
    Book('Book 1', 'assets/pdf/shmail.pdf'),
    Book('Book 2', 'assets/pdf/sera.pdf'),
    Book('Book 3', 'assets/pdf/hart.pdf'),
  ];
   Description_Books({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DescriptionBooksControllerImp());
    return GetBuilder<DescriptionBooksControllerImp>(
        builder: (controller)
    {
      return Scaffold(
        appBar:
            AppBar(
              backgroundColor: AppColor.primaryColor,
              actions: [
                IconButton(onPressed: (){
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
                  child: Column(children: [
                    const CircleAvatar(backgroundImage: AssetImage(
                        AppImageAssets.profileimage),),
                    const SizedBox(height: 20,),
                    Text("${controller.myServices.sharedPreferences.getString(
                        "username")}"),

                  ],)
              ),
              // ListTile(
              //   title: Text("144".tr),
              //   onTap: () {},
              // ),

              DropDownList(),
              DropDownList(isThemeApp:true),

              // ListTile(
              //   title: Text("145".tr),
              //   onTap: () {},
              // ),
              ListTile(
                title: Text("146".tr),
                onTap: () {},
              ),
              ListTile(
                title: Text("147".tr),
                onTap: () {},
              ),
              ListTile(
                title: Text( "160".tr),
                onTap: () {
                  Get.to(()=>Request());
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
                padding: const EdgeInsets.only(top: 20,left: 60,right: 60,),
                child: Image(image: AssetImage(AppImageAssets.coversh),
                ),
              ),
              SizedBox(height: 20,),
              Text("اسم الكتاب: الشمائل المحمّديّة"),
              SizedBox(height: 5,),
              Text("اسم الكاتب: الدكتور أدهم العاسمي"),
              SizedBox(height: 25,),
              Text("الوصف :",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 20,
              ),),
              Text("هذا الكتيب تلخيص لسلسلة الشمائل المحمدية لفضيلة الشيخ أدهم العاسمي وهو يتحدث عن صفات النبي محمد عليه الصلاة والسلام الخَلقية والخُلُقية"),
              SizedBox(
                height: 20,
              ),

              MaterialButton(onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookDetailScreen(book: books[0]),));

                // Get.toNamed(AppRoutes.showbook, parameters: {'pdfPath': 'assets/pdf/sera.pdf'}
                // );
// Get.to(ShowBook(pdfPath: '',));

//Navigator.push(context, MaterialPageRoute(builder: (context) => ShowBook(pdfPath: 'assets/pdf/sera.pdf',)));
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
    }
    );
  }
}

class Book {
  final String title;
  final String assetPath;

  Book(this.title, this.assetPath);
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
    fromAsset(widget.book.assetPath, 'temp.pdf').then((f) {
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
        title: Text(widget.book.title),
      ),
      body: localPath != null
          ? PDFView(
        filePath: localPath,
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}