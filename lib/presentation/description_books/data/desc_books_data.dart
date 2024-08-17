
import 'package:dartz/dartz.dart';
import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/services/services.dart';

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class DescriptionBooksData {
  Crud crud;
  DescriptionBooksData(this.crud);
MyServices myServices = Get.find();
  /// you just need to use the link, and to insert the form data
  dynamic getData() async {
    var response = await crud.postData(AppLink.descriptionbook, {});
    return response.fold((l) => l, (r) => r);
  }
  dynamic rateBook(String rating,int bookID) async {
    var response = await crud.postDataWithToken(AppLink.rateBooks(bookID),"", {"rating":rating});
    return response.fold((l) => l, (r) => r);
  }
}