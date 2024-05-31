import 'package:eqraa/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/imageassets.dart';
import '../../../core/functions/logout.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../../show_book/view/show_book.dart';
import '../controller/desc_books_controller.dart';

class Description_Books extends StatelessWidget {
  const Description_Books({super.key});

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
                IconButton(onPressed: (){},
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
              ListTile(
                title: Text("144".tr),
                onTap: () {},
              ),

              ListTile(
                title: Text("145".tr),
                onTap: () {},
              ),
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
              Text("هذا الكتيب تلخيص لسلسلة الشمائل المحمدية للدكتور أدهم العاسمي وهو يتحدث عن صفات النبي محمد عليه الصلاة والسلام الخَلقية والخُلُقية"),
              SizedBox(
                height: 20,
              ),
              MaterialButton(onPressed: (){
                Get.toNamed(AppRoutes.showbook, parameters: {'pdfPath': 'assets/My_PDF/تلخيص_كتاب_السيرة_النبوية_الشريفة_1.pdf'});

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
