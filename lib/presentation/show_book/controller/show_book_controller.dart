import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';
import '../../../routes.dart';
import '../data/show_book_data.dart';

abstract class ShowBookController extends GetxController {
  ShowBook();
}

class ShowBookControllerImp extends ShowBookController {
  MyServices myServices = Get.find();
  ShowBookData showbookdata = ShowBookData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List data = [];

  dynamic getData() async {
    statusRequest = StatusRequest.loading;
    var response = await showbookdata.getData(); // getting the data
    statusRequest = handlingData(response); //TO handle the response status
    if (StatusRequest.success == statusRequest) {
      data.addAll(response['data']);
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

  ///TODO : ريكويست تتبع الكتاب
  Future<void> saveHighestPage(int bookId, int page) async {
    // Implement the logic to save the highest page number in the database or shared preferences
    // You can call an API or use local storage to save the data
    print("Saving highest page reached: $page for book ID: $bookId");
    myServices.sharedPreferences.setString(bookId.toString(), page.toString());
    var response = await showbookdata.saveHighestPage(bookId, page);
    if (response is StatusRequest) {
      print("Failed to save on backend: $response");
    } else {
      print("Successfully saved on backend: $response");
    }
    // Example: Save it using shared preferences or call an API to save it on the server
  }

  getLastSavedPage(int bookId) async {
    String? savedPage =
        myServices.sharedPreferences.getString(bookId.toString());
    return savedPage != null ? int.tryParse(savedPage) ?? 0 : 0;
  }

  @override
  ShowBook() {
    Get.toNamed(AppRoutes.showbook);
  }
}
