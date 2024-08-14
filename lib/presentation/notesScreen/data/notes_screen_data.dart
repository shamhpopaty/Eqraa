
import '../../../core/class/crud.dart';
import '../../../data/token_manager.dart';
import '../../../linkapi.dart';

class NotesScreenData {
  Crud crud;
  NotesScreenData(this.crud);

  /// you just need to use the link, and to insert the form data
  dynamic getData(String category) async {
    var response = await crud.getDataWithToken(AppLink.notesscreen,"");
    return response.fold((l) => l, (r) => r);
  }
}