
import '../../../core/class/crud.dart';
import '../../../data/token_manager.dart';
import '../../../linkapi.dart';

class FavoriteScreenData {
  Crud crud;
  FavoriteScreenData(this.crud);

  /// you just need to use the link, and to insert the form data
  dynamic getData() async {
    var response = await crud.getDataWithToken(AppLink.getfavoritebook, "");
    return response.fold((l) => l, (r) => r);
  }
}