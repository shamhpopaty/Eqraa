import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/constant/color.dart';
import 'package:eqraa/models/notes_model.dart';
import 'package:eqraa/presentation/My_favoriteScreen/controller/my_favorite_controller.dart';
import 'package:eqraa/presentation/booksScreen/model/books_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/localization/changelocal.dart';
import '../models/book_model.dart';
import '../presentation/notesScreen/controller/notes_screen_controller.dart';

class Favorite_Item extends StatelessWidget {
  final Book favorites;
  final FavoriteScreenControllerImp favoriteScreenControllerImp;

  Favorite_Item({super.key, required this.favorites, required this.favoriteScreenControllerImp});

  final LocaleController localController = Get.put(LocaleController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: (!localController.isDark) ? Colors.red[200]: AppColor.primaryColorDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              favorites.title ?? "No Title", // عرض اسم الملاحظة
              style: TextStyle(
                color: (!localController.isDark) ? Colors.black : Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                favorites.author ?? "No Notes", // عرض النص الكامل للملاحظة
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              "Page: ${favorites.numberOfPages}", // عرض رقم الصفحة
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
