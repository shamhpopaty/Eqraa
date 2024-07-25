// ignore_for_file: avoid_print

import 'package:eqraa/data/token_manager.dart';
import 'package:eqraa/models/book_model.dart';

import '../../core/class/crud.dart';
import '../../linkapi.dart';

class HomeData {
  Crud crud;

  HomeData(this.crud);

  /// you just need to use the link, and to insert the form data
  getData() async {
    TokenManager tokenManager = TokenManager();
    String token = await tokenManager.accessToken;
    // TODO: delete
    token = '2|ujyhkF4QVNFrqqYGyEeNThBFjQkT8vAY3EySvOmMcb7e580d';
    var response = await crud.getDataWithToken(AppLink.home, token);
    // var response2 = await crud.postData(AppLink.home, Book_Modele().toJson());
    // var response3 = await crud.postDataWithToken(
    //   AppLink.home,
    //   token,
    //   body: Book_Modele().toJson(),
    // );
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
