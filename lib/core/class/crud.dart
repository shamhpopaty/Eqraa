import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:eqraa/data/token_manager.dart';
import 'package:http/http.dart' as http;
import '../functions/check_internet.dart';
import 'status_request.dart';

class Crud {
  // Future<Either<StatusRequest, Map>> postData(
  //   String linkurl,
  //   Map<String, String> data,
  // ) async {
  //   var headers = {
  //     'Accept': 'application/json',
  //     // Since you're using bodyFields, you don't need to set the Content-Type header here.
  //     // The http package will automatically set it to application/x-www-form-urlencoded.
  //   };
  //   var request = http.Request('POST', Uri.parse(linkurl));
  //   request.bodyFields = data; // Use bodyFields for URL-encoded form data
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //   print(response.statusCode);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     String responseBody = await response.stream.bytesToString();
  //     Map responsebody = jsonDecode(responseBody);
  //     print(responsebody);
  //     return Right(responsebody);
  //   } else {
  //     print(response.reasonPhrase);
  //     return const Left(StatusRequest.serverFailure);
  //   }
  // }
  Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
    // if (await checkInternet()) {
    var response = await http.post(Uri.parse(linkurl), body: data);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      print(responsebody);

      if (responsebody['token'] != null) {
        TokenManager tokenManager = TokenManager();
        await tokenManager.setToken(access: responsebody['token']);
      }

      return Right(responsebody);
    } else if (response.statusCode == 400) {
      return const Left(StatusRequest.failure);
    } else {
      return const Left(StatusRequest.serverFailure);
    }
  }

  // else {
  //   return const Left(StatusRequest.offlineFailure);
  // }
  // }

  Future<Either<StatusRequest, Map>> getDataWithToken(
    String linkurl,
    String bearerToken,
  ) async {
    try {
      var response = await http.get(
        Uri.parse(linkurl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
      );

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print('Response Body: $responsebody');
        return Right(responsebody);
      } else {
        print('Error: Server Failure');
        return const Left(StatusRequest.serverFailure);
      }
    } catch (e) {
      print('Error: $e');
      return const Left(StatusRequest.failure);
    }
  }

  Future<Either<StatusRequest, Map>> postDataWithToken(
    String linkurl,
    String bearerToken, {
    Map<String, dynamic>?
        body, // Add an optional body parameter for POST requests
  }) async {
    try {
      var response = await http.post(
        Uri.parse(linkurl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken',
        },
        body: jsonEncode(body), // Encode the body as JSON
      );

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map responsebody = jsonDecode(response.body);
        print('Response Body: $responsebody');
        return Right(responsebody);
      } else {
        print('Error: Server Failure');
        return const Left(StatusRequest.serverFailure);
      }
    } catch (e) {
      print('Error: $e');
      return const Left(StatusRequest.failure);
    }
  }
}

Future<Either<StatusRequest, Map>> get(
  String linkurl,
  String? bearerToken,
) async {
  try {
    var response = await http.get(
      Uri.parse(linkurl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
    );

    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      print('Response Body: $responsebody');
      return Right(responsebody);
    } else if (response.statusCode == 400) {
      return const Left(StatusRequest.failure);
    } else {
      print('Error: Server Failure');
      return const Left(StatusRequest.serverFailure);
    }
  } catch (e) {
    print('Error: $e');
    return const Left(StatusRequest.offlineFailure);
  }
}

Future<Either<StatusRequest, Map>> post(
  String linkurl,
  String bearerToken, {
  Map<String, dynamic>?
      body, // Add an optional body parameter for POST requests
}) async {
  try {
    var response = await http.post(
      Uri.parse(linkurl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      },
      body: jsonEncode(body), // Encode the body as JSON
    );

    print('Response Status Code: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map responsebody = jsonDecode(response.body);
      print('Response Body: $responsebody');
      return Right(responsebody);
    } else if (response.statusCode == 400) {
      return const Left(StatusRequest.failure);
    } else {
      print('Error: Server Failure');
      return const Left(StatusRequest.serverFailure);
    }
  } catch (e) {
    print('Error: $e');
    return const Left(StatusRequest.failure);
  }
}
