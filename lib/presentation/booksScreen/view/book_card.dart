import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constant/imageassets.dart';
import '../../../linkapi.dart';
import '../../../models/book_model.dart';

import '../model/books_model.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final DateTime? selectedTime;
  final VoidCallback onTimePicked;
  final bool isDark;
  void Function()? onTap;

  BookCard({
    required this.book,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.selectedTime,
    required this.onTimePicked,
    required this.isDark,
     this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: isDark ? Colors.grey[850] : Colors.white,
        elevation: 5,
        child: Column(
          children: [
        Image.network(
        "${AppLink.baseServer}/storage/${book.cover!}",
          fit: BoxFit.cover,
          height: 120,
          errorBuilder: (context, error,
              stackTrace) {
            return Image.asset(
                height: 120,
                AppImageAssets.camera,
                fit: BoxFit.cover);
          },
        ),



            const SizedBox(height: 2),
            Text(book.title ?? ''),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.alarm),
                  onPressed: onTimePicked,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: onFavoriteToggle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

