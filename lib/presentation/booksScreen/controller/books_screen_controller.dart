import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/books_model.dart';

class BooksScreenControllerImp extends GetxController {
  List<Book> books = [];
  var isLoading = true.obs;
  final String category;

  BooksScreenControllerImp(this.category);

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
    final url = 'http://192.168.247.175:8000/api/books?search=category[l]=$category';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer 5|eEH5v9BDZ3t5lGHTi8zOc9Ga9OkMWwRBFhlrHBw392a3d872',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)['books'];
      print(response.body);
      isLoading.value = false;

      books = data.map((book) => Book.fromJson(book)).toList();
    } else {
      // Handle errors
      print('Failed to load books');
      isLoading.value = false;

    }

  }
}
