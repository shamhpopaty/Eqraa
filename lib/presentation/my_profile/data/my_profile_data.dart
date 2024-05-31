// ignore_for_file: avoid_print

import 'package:http/http.dart';

import '../../../../core/class/crud.dart';

import '../../../../core/class/status_request.dart';
import '../../../../linkapi.dart';

class MyProfileData {
  Crud crud;
  MyProfileData(this.crud);

  getData()
  async {

  var response = await crud.postData(AppLink.test, {});
  return response.fold((l) => l, (r) => r);
  }
  }




