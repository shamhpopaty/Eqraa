import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/functions/logout.dart';
import '../Auth/controller/login_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());
    return Scaffold(
      body: InkWell(
        onTap: () {
          logOut();
        },
        child: const Center(child: Text("LogOut")),
      ),
    );
  }
}
