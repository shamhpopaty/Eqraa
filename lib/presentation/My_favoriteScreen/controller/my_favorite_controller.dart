import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eqraa/models/book_model.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../data/token_manager.dart';
import '../../booksScreen/model/books_model.dart';
import '../data/my_favorite_data.dart';
import 'package:http/http.dart'as http;

class FavoriteScreenControllerImp extends GetxController {
  // List for filtered books
  var isFavorite = false.obs;
  List<Book> filteredBooks = []; // List for filtered books


  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  var isLoading = true.obs;
  List<Book_Modele> favorite = [];

  var searchQuery = ''.obs; // Observable for search query
  StatusRequest statusRequest = StatusRequest.none;
  FavoriteScreenData favoriteScreenData = FavoriteScreenData(Get.find());

  FavoriteScreenControllerImp();

  final TokenManager tokenManager = TokenManager();

  @override
  void onInit() {
    super.onInit();
    getfavoritebook();
    // Listen to changes in search query
  }


  Future<void> getfavoritebook() async {
    String accessToken = await TokenManager().accessToken;
    //var response = await favoriteScreenData.getData();

    var response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/books/my-favorite'),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {

      List temp = jsonDecode(response.body);
      favorite = temp.map((item) => Book_Modele()).toList();
      statusRequest = StatusRequest.success; // تغيير حالة الطلب إلى success
    } else {
      Get.snackbar('notSuccess', jsonDecode(response.body).toString());
      statusRequest = StatusRequest.failure; // تغيير حالة الطلب إلى failure في حالة الفشل
    }

    update();
  }
  Future<void> addFavoriteBook(int id) async {
    String accessToken = await TokenManager().accessToken;
    var response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/books/$id/add-to-favorite'),
      headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      },
    );

    print(response.statusCode);


    if (response.statusCode == 200) {
     //Get.snackbar('Success', 'تمت اضافة الكتاب بنجاح');
    } else {
      Get.snackbar('not Success', jsonDecode(response.body).toString());
    }
  }

}

