import 'dart:convert';

import 'package:eqraa/core/app_export.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart'as http;
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/token_manager.dart';
import '../data/books_screen_data.dart';
import '../model/books_model.dart';

class BooksScreenControllerImp extends GetxController {
  List<Book> books = [];
  List<Book> filteredBooks = []; // List for filtered books

  var isLoading = true.obs;
  var searchQuery = ''.obs; // Observable for search query
  final String category;
  StatusRequest statusRequest = StatusRequest.none;
  BooksScreenData booksScreenData = BooksScreenData(Get.find());
  BooksScreenControllerImp(this.category);
  final TokenManager tokenManager = TokenManager();

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
    searchQuery.listen((query) => filterBooks()); // Listen to changes in search query
  }
  Future<void> addBookMark(
      String name, int bookId, int pageNumber, String note) async {
    String accessToken = await TokenManager().accessToken;
    var response = await http
        .post(Uri.parse('http://127.0.0.1:8000/api/bookmarks'), body: {
      "name": name,
      "book_id": bookId.toString(),
      "page_number": pageNumber.toString(),
      "note": note,
    }, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });
    print(response.statusCode);
    if (response.statusCode == 201) {
      Get.snackbar('success', 'تمت اضافة الملاحظة بنجاح');
    } else {
      Get.snackbar('notSuccess', jsonDecode(response.body).toString());
    }
  }

  Future<void> fetchBooks() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await booksScreenData.getData(category);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      List<dynamic> booksJson = response['books'];
      books = booksJson
          .map((book) => Book.fromJson(book as Map<String, dynamic>))
          .toList();
      filteredBooks = books; // Initialize filteredBooks
    } else {
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  void filterBooks() {
    if (searchQuery.value.isEmpty) {
      filteredBooks = books;
    } else {
      filteredBooks = books.where((book) {
        return book.title!.toLowerCase().contains(searchQuery.value.toLowerCase());
      }).toList();
    }
    update();
  }
}
