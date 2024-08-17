import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/changelocal.dart';
import '../presentation/notesScreen/controller/notes_screen_controller.dart';

class NoteItem extends StatelessWidget {
  final Notes_Model note;
  final NotesScreenControllerImp controller;

  NoteItem({super.key, required this.note, required this.controller});

  final LocaleController localController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: (!localController.isDark) ? AppColor.fourthColor : AppColor.primaryColorDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              note.name ?? "No Title", // عرض اسم الملاحظة
              style: TextStyle(
                color: (!localController.isDark) ? Colors.black : Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                note.note ?? "No Notes", // عرض النص الكامل للملاحظة
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: () async {
                // استدعاء التابع لحذف الملاحظة عند الضغط على أيقونة الحذف
                await controller.deleteNote(note.id!);
              },
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(

              "Page: ${note.pageNumber}", // عرض رقم الصفحة
              style: TextStyle(
                color: Colors.black.withOpacity(0.4),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
