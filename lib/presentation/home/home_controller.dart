import 'package:get/get.dart';
import '../../core/class/status_request.dart';
import '../../core/functions/handling_data_controller.dart';
import 'home_data.dart';

class HomeController extends GetxController {
  HomeController(){
    getData();
  }

  HomeData homeData = HomeData(Get.find());

  List data = [];
  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await homeData.getData(); // getting the data
    statusRequest = handlingData(response); //TO handle the response status
    if (StatusRequest.success == statusRequest) {
      // data.addAll(response['data']);
      print(response['books']);
    } else {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}

/*import 'package:eqraa/core/app_export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;
  var books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }


  void fetchCategories() async {
    isLoading(true);
    final String token ='21|SpsC4oiROaKFT66mLU3DWVu2t9qwg4jGX3inOCA23170f84e';
    try {
      var response = await http.get(Uri.parse('http://127.0.0.1:8000/api/books'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print(data); // طباعة البيانات المستلمة للتحقق من نوعها
        if (data is Map<String, dynamic> && data.containsKey('books')) {
          var booksData = data['books'];
          if (booksData is List) {
            categories.value = booksData.map((json) => Category.fromJson(json)).toList();
          } else {
            print("Error: Expected 'books' to be a list but got ${booksData.runtimeType}");
          }
        } else {
          print("Error: Expected a map with a 'books' key but got ${data.runtimeType}");
        }

      } else {
        print("Failed to load categories");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchSubjects(int categoryId) async {
    isLoading(true);
    final String token = '21|SpsC4oiROaKFT66mLU3DWVu2t9qwg4jGX3inOCA23170f84e';
    try {
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/books/1'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      print('i am in');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // تحويل بيانات الكتاب المستلمة مباشرة إلى كائن كتاب واحد
        Book book = Book.fromJson(data);
        // إضافة الكتاب إلى قائمة الكتب
        books.value = [book];
        print("Subjects loaded successfully: ${books.length} items");
        print("Response body: ${response.body}");
      } else {
        print("Failed to load subjects: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }






}
class Book {
  final int id;
  final String title;
  final String category;
  final String author;
  final String description;
  final double rating;
  final String cover;
  final String path;
  final int numberOfPages;
  final String createdAt;
  final String updatedAt;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.author,
    required this.description,
    required this.rating,
    required this.cover,
    required this.path,
    required this.numberOfPages,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? 0,
      title: json['title'] != null ? json['title'] : 'Unknown',
      category: json['category'] != null ? json['category'] : 'Unknown',
      author: json['author'] != null ? json['author'] : 'Unknown',
      description: json['description'] != null ? json['description'] : 'No description',
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
      cover: json['cover'] != null ? json['cover'] : '',
      path: json['path'] != null ? json['path'] : '',
      numberOfPages: json['number_of_pages'] != null ? json['number_of_pages'] : 0,
      createdAt: json['created_at'] != null ? json['created_at'] : '',
      updatedAt: json['updated_at'] != null ? json['updated_at'] : '',
    );
  }


}

class Category {
  final int id;
  final String category;


  Category({
    required this.id,
    required this.category,

  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      category: json['category'] ?? 'Unknown',

    );
  }
}
*/
