import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/class/handlingdataview.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/widgets/custom_container_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';


import '../presentation/My_Profile/controller/my_profile_controller.dart';
import 'custom_editing_profile.dart';
import 'custom_profile.dart';

class Custom_Profile extends StatelessWidget {


  Custom_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyProfileControllerImp());

    return GetBuilder<MyProfileControllerImp>(
        builder: (controller) {

    return  HandlingDataView(
      statusRequest: controller.statusRequest,
      widget: Column(
        children: [
          const Row(
            children: [
              SizedBox(width: 130,),
              SizedBox(
                height: 115,width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(AppImageAssets.profileimage),
                    ),
                  ],
                ),
              ),
            ],
          ),
      const SizedBox(
        height: 30,
      ),
          Text('${controller.username}',
          style: const TextStyle(
              color: AppColor.primaryColor,
      fontWeight: FontWeight.bold),),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: (){
                Get.to(EditProfile());
              }, icon: const Icon(Icons.edit)),
            ],
          ),

      Padding(
        padding: const EdgeInsets.only(top: 8,bottom: 8),
        child: Column(
          children: [
      Container(
        height: 50,
        width: 400,
        child: Row(
          children: [
            const Icon(Icons.account_box_outlined),
            const SizedBox(width: 10),
            Text("153".tr,
            style: const TextStyle(
              color: AppColor.black,
              fontWeight: FontWeight.bold
            ),),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
        child: Text("اجعل من نفسك شيء يصعب تقليده",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold
        ),),
      ),
      const Divider(),
      Container(
        height: 50,
        width: 400,
        child: Row(
          children: [
            const Icon(Icons.link_outlined),
            const SizedBox(width: 10),
            Text("154".tr,
              style: const TextStyle(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold
              ),),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
        child: Text("www.facebook.com"),
      ),
      const Divider(),
            container_profile2(Icons.format_list_numbered_rtl_outlined, "151".tr,50 ),
      const Divider(),
            container_profile3(Icons.library_books_outlined, "155".tr, 40),
      const Divider(),
            container_profile(Icons.stacked_bar_chart_outlined,
            "150".tr, Icons.arrow_circle_left_outlined),
            const Divider(),
            container_profile4(Icons.table_chart_rounded,
                "156".tr, Icons.arrow_circle_left_outlined),

          ],
        ),
      ),
      ],
      ),
    );
        },
    );
  }

}

