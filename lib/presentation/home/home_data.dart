// ignore_for_file: avoid_print

import '../../core/class/crud.dart';
import '../../linkapi.dart';

class HomeData {
  Crud crud;
  HomeData(this.crud);

  /// you just need to use the link, and to insert the form data
  getData() async {
    var response = await crud.postData(AppLink.home, {});
    return response.fold((l) => l, (r) => r);
  }
}

/*import 'package:http/http.dart';

import '../../core/class/crud.dart';
import '../../core/class/status_request.dart';
import '../../linkapi.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  getData() async {
    const maxRetries = 10;
    for (var i = 0; i < maxRetries; i++) {
      try {
        var response = await crud.postData(AppLink.home, {
          
        });
        return response.fold((l) => l, (r) => r);
      } catch (e) {
        await Future.delayed(const Duration(seconds: 2));
        print("Retrying ...$maxRetries");
        if (e is ClientException) {
          return StatusRequest.offlineFailure;
        } else {
          // Handle other exceptions
          print('Unexpected error: $e');
        }
      }
    }
    throw Exception('Failed after $maxRetries retries');
  }
}
*/