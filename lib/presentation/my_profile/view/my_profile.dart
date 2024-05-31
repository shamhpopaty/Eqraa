import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/presentation/My_Profile/controller/my_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../widgets/custom_profile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyProfileControllerImp());
    return Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Column(
          children: [
            Custom_Profile(),

          ],
        ),
      ),
    );
  }
}
