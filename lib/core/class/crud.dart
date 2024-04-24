// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:http/http.dart' as http;

import '../functions/check_internet.dart';
import 'status_request.dart';

/// HANDLE THE RESPONSE.
class Crud {
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    if (await checkInternet()) {
      var response = await http.post(Uri.parse(linkurl), body: data);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print(responsebody);
        return Right(responsebody);
      } else {
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }
}
