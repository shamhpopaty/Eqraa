import 'package:eqraa/core/app_export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/class/handlingdataview.dart';
import '../../../core/constant/color.dart';
import '../../../core/functions/alert_alarm.dart';
import '../../../core/localization/changelocal.dart';
import '../../../widgets/custom_note_item.dart';
import '../../../widgets/homeScreen/customappbar.dart';
import '../controller/notes_screen_controller.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    final NotesScreenControllerImp notesScreenController = Get.put(NotesScreenControllerImp());

    return Scaffold(
      backgroundColor: (!localController.isDark) ? AppColor.white : AppColor.black,
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
                    backgroundImage: AssetImage(AppImageAssets.profileimage),
                  ),
                  const SizedBox(height: 20),
                  // Text("${controller.myServices.sharedPreferences.getString("username")??"Kheder Youssef"}"),
                ],
              ),
            ),
            // بقية الكود الخاص بالـ Drawer
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<NotesScreenControllerImp>(builder: (notesScreenController) {
                LocaleController localController = Get.put(LocaleController());
                return HandlingDataView(
                  statusRequest: notesScreenController.statusRequest,
                  widget: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // لجعل القائمة تعمل بسلاسة داخل ScrollView
                    itemCount: notesScreenController.notes.length,
                    itemBuilder: (context, index) {
                      final note = notesScreenController.notes[index];
                      return Column(
                        children: [
                          NoteItem(note: note, controller: notesScreenController,),
                          SizedBox(height: 20,)
                        ],
                      ); // تمرير البيانات إلى الـ NoteItem
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
