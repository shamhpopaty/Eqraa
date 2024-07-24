// ignore_for_file: deprecated_member_use

import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/presentation/My_Profile/view/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/functions/logout.dart';
import '../../widgets/drop_down_list_drawer.dart';
import '../recieved_requestScreen/screen/recieved_request.dart';
import '../send_requestsScreen/screens/send_requests.dart';
import 'homescreen_controller.dart';
import '../../../core/functions/alert_exit_app.dart';
import '../../widgets/homeScreen/custom_bottom_app_bar_home.dart';
import '../../widgets/homeScreen/customappbar.dart';


class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());

    return GetBuilder<HomeScreenControllerImp>(
      builder: (controller) {
        return Scaffold(
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
            bottomNavigationBar: const CustomBottomAppBarHome(),
            body:
                controller.listPage.elementAt(controller.currentPage),
          );
      },
    );
  }
}
