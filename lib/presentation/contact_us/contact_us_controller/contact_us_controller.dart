import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../data/token_manager.dart';
import '../../../linkapi.dart';
import '../contact_us_data/contact_us_data.dart';


class ContactUsController extends GetxController {
  ContactUsData contactUsData = ContactUsData(Get.find());

  List data = [];
  late StatusRequest statusRequest;

  getData() async {
    statusRequest = StatusRequest.loading;
    var response = await contactUsData.getData(); // getting the data
    statusRequest = handlingData(response); //TO handle the response status
    if (StatusRequest.success == statusRequest) {

      data.addAll(response['data']);}
    else {
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
Future<void> addComplaints(String content) async {
  String accessToken = await TokenManager().accessToken;
  var response = await http.post(Uri.parse(AppLink.addBookMark), body: {
    "content": content,
  }, headers: {
    "Accept": "application/json",
    'Authorization': 'Bearer $accessToken',
  });
  print(response.statusCode);
  if (response.statusCode == 201) {
    Get.snackbar('success', 'تمت ارسال الشكوى بنجاح');
  } else {
    Get.snackbar('notSuccess', jsonDecode(response.body).toString());
  }
}