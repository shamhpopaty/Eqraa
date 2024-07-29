
import '../../../core/class/crud.dart';
import '../../../data/token_manager.dart';
import '../../../linkapi.dart';

class BooksScreenData {
  Crud crud;
  BooksScreenData(this.crud);

  /// you just need to use the link, and to insert the form data
  dynamic getData(String category) async {
    var response = await crud.getDataWithToken(AppLink.bookscreen+category, "",);
    return response.fold((l) => l, (r) => r);
  }
}