import 'package:eqraa/core/class/status_request.dart';
import 'package:eqraa/core/functions/handling_data_controller.dart';
import 'package:eqraa/models/book_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/notes_screen_data.dart';


class NotesScreenControllerImp extends GetxController {
  var isLoading = true.obs;
  StatusRequest statusRequest = StatusRequest.none;
  NotesScreenData booksScreenData = NotesScreenData(Get.find());


  @override
  void onInit() {
    super.onInit();

  }

}
