import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/class/handlingdataview.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/my_profile/controller/my_profile_controller.dart';
import 'custom_container_profile.dart';
import 'custom_editing_profile.dart';

class Custom_Profile extends StatelessWidget {
  Custom_Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyProfileController());

    return Obx(() {
      return HandlingDataView(
        statusRequest: controller.statusRequest.value,
        widget: Column(
          children: [
            const Row(
              children: [
                SizedBox(width: 130,),
                SizedBox(
                  height: 115, width: 115,
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
            const SizedBox(height: 30),
            Text(
              '${controller.userProfile.value.user?.name ?? ''}',
              style: const TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(EditProfile());
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: 300,
                    child: Row(
                      children: [
                        const Icon(Icons.account_box_outlined),
                        const SizedBox(width: 10),
                        Text(
                          "153".tr,
                          style: const TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      controller.userProfile.value.user?.bio ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 50,
                    width: 400,
                    child: Row(
                      children: [
                        const Icon(Icons.link_outlined),
                        const SizedBox(width: 10),
                        Text(
                          "154".tr,
                          style: const TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      controller.userProfile.value.user?.socialLinks ?? '',
                    ),
                  ),
                  const Divider(),
                  container_profile2(
                    Icons.format_list_numbered_rtl_outlined,
                    "151".tr,
                    controller.userProfile.value.user?.numberOfFriends ?? 0,
                  ),
                  const Divider(),
                  container_profile3(
                    Icons.library_books_outlined,
                    "155".tr,
                    controller.userProfile.value.userBooks?.length ?? 0,
                  ),
                  const Divider(),
                  container_profile(
                    Icons.stacked_bar_chart_outlined,
                    "150".tr,
                    Icons.arrow_circle_left_outlined,
                  ),
                  const Divider(),
                  container_profile4(
                    Icons.table_chart_rounded,
                    "156".tr,
                    Icons.arrow_circle_left_outlined,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
