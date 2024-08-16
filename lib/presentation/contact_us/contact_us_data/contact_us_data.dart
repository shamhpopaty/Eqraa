

import '../../../core/class/crud.dart';
import '../../../linkapi.dart';

class ContactUsData {
  Crud crud;
  ContactUsData(this.crud);

  /// you just need to use the link, and to insert the form data
  getData() async {
    var response = await crud.postData(AppLink.addcomplaints, {});
    return response.fold((l) => l, (r) => r);
  }
}
