import 'dart:convert';
import 'package:get/get.dart';
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/token_manager.dart';
import '../../../models/book_model.dart';
import '../data/my_favorite_data.dart';
import '../../booksScreen/model/books_model.dart';

class FavoriteScreenControllerImp extends GetxController {
  List<Book> favoriteBooks = <Book>[].obs;
  StatusRequest statusRequest = StatusRequest.none;
  FavoriteScreenData favoriteScreenData = FavoriteScreenData(Get.find());
  final TokenManager tokenManager = TokenManager();

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteBooks();
  }

  // Fetch favorite books from API
  Future<void> fetchFavoriteBooks() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await favoriteScreenData.getData();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success && response is List) {
      favoriteBooks = response.map((json) => Book.fromJson(json)).toList().obs;
    } else {
      Get.snackbar('Error', 'Failed to fetch favorite books.');
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  // Toggle favorite status of a book
  Future<void> toggleFavoriteBook(Book book) async {
    if (isBookFavorite(book.id!)) {
      await removeFavoriteBook(book);
    } else {
      await addFavoriteBook(book);
    }
  }

  // Add a book to favorites
  Future<void> addFavoriteBook(Book book) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await favoriteScreenData.addFavoriteBook(book.id!);

    if (response is Map && response.containsKey('success')) {
      favoriteBooks.add(book);
      Get.snackbar('Success', 'Book added to favorites');
    } else {
      Get.snackbar('Error', 'Failed to add book to favorites');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  // Remove a book from favorites
  Future<void> removeFavoriteBook(Book book) async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await favoriteScreenData.removeFavoriteBook(book.id!);

    if (response is Map && response.containsKey('success')) {
      favoriteBooks.removeWhere((b) => b.id == book.id);
      Get.snackbar('Success', 'Book removed from favorites');
    } else {
      Get.snackbar('Error', 'Failed to remove book from favorites');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  // Check if a book is in the favorite list
  bool isBookFavorite(int id) {
    return favoriteBooks.any((book) => book.id == id);
  }
}
