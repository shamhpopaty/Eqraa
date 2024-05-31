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

  @override
  ShowBook() {
    Get.toNamed(AppRoutes.showbook);

  }
}
