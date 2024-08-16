import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class ShowBookData {
  Crud crud;
  ShowBookData(this.crud);

  /// you just need to use the link, and to insert the form data
  dynamic getData() async {
    var response = await crud.getDataWithToken(AppLink.showbook, "");
    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> saveHighestPage(int bookId, int pageNumber) async {
    // Construct the endpoint URL using the book ID
    String url = "${AppLink.server}/books/$bookId/read";

    // Prepare the form data
    Map<String, dynamic> data = {"page_number": pageNumber};

    // Send the POST request
    var response = await crud.postDataWithToken(
      url,
      "",
      data,
    );
    return response.fold((l) => l, (r) => r); // Handle the response
  }
}
