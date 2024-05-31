import 'package:eqraa/presentation/description_books/view/desc_books.dart';
import 'package:get/get.dart';

import '../../../core/class/status_request.dart';
import '../../../core/functions/handling_data_controller.dart';
import '../../../core/services/services.dart';
import '../../../routes.dart';
import '../data/books_screen_data.dart';

abstract class DescriptionBooksController extends GetxController {
  Books_Screen();
}


class BooksScreenControllerImp extends DescriptionBooksController {
  MyServices myServices = Get.find();
  BooksScreenData bookscreendata = BooksScreenData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  List data = [];

  dynamic getData() async {
    statusRequest = StatusRequest.loading;
    var response = await bookscreendata.getData(); // getting the data
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
  Books_Screen() {
    Get.toNamed(AppRoutes.bookscreen);

  }
}
