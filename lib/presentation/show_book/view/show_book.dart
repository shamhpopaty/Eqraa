import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';

// import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/drop_down_list_drawer.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../controller/show_book_controller.dart';
import 'package:permission_handler/permission_handler.dart';

/*class ShowBook extends StatelessWidget {
  const ShowBook({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ShowBookControllerImp());
    return GetBuilder<ShowBookControllerImp>(
        builder: (controller) {

      return SafeArea(child: Scaffold(
          appBar: const CustomAppBarHome(),
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
    ListTile(
    title: Text( "144".tr),
    onTap: () {
    },
    ),

    ListTile(
    title: Text("145".tr),
    onTap: () {
    },
    ),
    ListTile(
    title: Text( "146".tr),
    onTap: () {
    },
    ),
    ListTile(
    title: Text( "147".tr),
    onTap: () {
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
    body:PDFView(
      filePath: Uri.file("assets/My_PDF/تلخيص_كتاب_السيرة_النبوية_الشريفة_1.pdf").toString(),
      enableSwipe: true,
      swipeHorizontal: true,
      autoSpacing: false,
      pageFling: false,
      pageSnap: true,
      onError: (error) {
        print(error.toString());
      },
      onPageError: (page, error) {
        print('$page: ${error.toString()}');
      },
onPageChanged: (page, total)=> print("page change: $page/$total"),
    ),
    ) ,
    );
  }
    );
}
}
*/

class ShowBook extends StatefulWidget {
  final String pdfPath;

  ShowBook({super.key, required this.pdfPath}) {
    ;
  }

  @override
  _ShowBookState createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  void initState() {
    super.initState();
    // _requestPermissions();
  }

  // late PDFViewController pdfViewController;
  // Future<void> _requestPermissions() async {
  //   if (await Permission.storage.request().isGranted) {
  //     Get.toNamed(AppRoutes.showbook, parameters: {'pdfPath': '"assets/My_PDF/تلخيص_كتاب_السيرة_النبوية_الشريفة_1.pdf"'});
  //   } else {
  //     // الإذن مرفوض، قم بإظهار رسالة للمستخدم
  //     print('Permission denied');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Get.put(ShowBookControllerImp());
    return SafeArea(
      child: Scaffold(
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

                      // Text("${controller.myServices.sharedPreferences
                      //     .getString("username")}"),
                    ],
                  )),
              // ListTile(
              //   title: Text("144".tr),
              //   onTap: () {},
              // ),
              DropDownList(),
              DropDownList(isThemeApp: true),
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
                title: Text("56".tr),
                onTap: () {
                  logOut();
                },
              ),
            ],
          ),
        ),
        body: SfPdfViewer.asset('assets/pdf/sera.pdf'),

        /*
        body: SfPdfViewer.network(
          'assets/pdf/sera.pdf'

      ),
       */
      ),
    );
  }
/*

  @override
  Widget build(BuildContext context) {
    Get.put(ShowBookControllerImp());
    return GetBuilder<ShowBookControllerImp>(
        builder: (controller) {
          return SafeArea(child: Scaffold(
            appBar: const CustomAppBarHome(),
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
                        Text("${controller.myServices.sharedPreferences
                            .getString("username")}"),

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
                    title: Text("56".tr),
                    onTap: () {
                      logOut();
                    },
                  ),
                ],
              ),
            ),
            body:

            PDFView(
              filePath: widget.pdfPath,
              autoSpacing: true,
              enableSwipe: true,
              pageSnap: true,
              swipeHorizontal: true,
              onError: (error) {
                print(error);
              },
              onPageError: (page, error) {
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController vc) {
                pdfViewController = vc;
              },
              /*onPageChanged: (int page, int total) {
          print('page change: $page/$total');
        },*/
            ),
          ),
          );
        }
    );
  }
   */
}

// Future<void> _requestPermissions() async {
//   if (await Permission.storage.request().isGranted) {
//     Get.toNamed(AppRoutes.showbook, parameters: {'pdfPath': '"assets/My_PDF/تلخيص_كتاب_السيرة_النبوية_الشريفة_1.pdf"'});
//   } else {
//     // الإذن مرفوض، قم بإظهار رسالة للمستخدم
//     print('Permission denied');
//   }
// }
