
import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class DescriptionBooksData {
  Crud crud;
  DescriptionBooksData(this.crud);

  /// you just need to use the link, and to insert the form data
  dynamic getData() async {
    var response = await crud.postData(AppLink.descriptionbook, {});
    return response.fold((l) => l, (r) => r);
  }
}