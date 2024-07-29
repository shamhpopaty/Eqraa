import 'package:eqraa/core/class/status_request.dart';
import 'package:eqraa/core/functions/handling_data_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/books_screen_data.dart';
import '../model/books_model.dart';

class BooksScreenControllerImp extends GetxController {
  List<Book> books = [];
  var isLoading = true.obs;
  final String category;
 StatusRequest statusRequest = StatusRequest.none;
  BooksScreenData booksScreenData = BooksScreenData(Get.find());
  BooksScreenControllerImp(this.category);

  @override
  void onInit() {
    super.onInit();
    fetchBooks();
  }

  Future<void> fetchBooks() async {
   statusRequest = StatusRequest.loading;
   update();
   var response = await booksScreenData.getData(category);
   statusRequest = handlingData(response);
   if(statusRequest == StatusRequest.success){
     List<dynamic> booksJson = response['books'];
     books = booksJson.map((book) => Book.fromJson(book as Map<String, dynamic>)).toList();

   }else{
     statusRequest = StatusRequest.failure;
   }
   update();


      // isLoading.value = false;

      //




  }
}
