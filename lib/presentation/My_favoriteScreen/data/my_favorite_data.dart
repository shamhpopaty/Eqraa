import '../../../core/class/crud.dart';
import '../../../data/token_manager.dart';
import '../../../linkapi.dart';

class FavoriteScreenData {
  final Crud crud;
  FavoriteScreenData(this.crud);
  final TokenManager tokenManager = TokenManager();

  // Fetch favorite books
  Future<dynamic> getData() async {
    String accessToken = await tokenManager.accessToken;
    var response = await crud.getDataWithToken(AppLink.getfavoritebook, accessToken);
    return response.fold((l) => l, (r) => r);
  }

  // Remove a book from favorites
  Future<dynamic> removeFavoriteBook(int id) async {
    String url = '${AppLink.server}/books/$id/remove-from-favorite';
    var response = await crud.deleteDataWithToken(url);
    return response.fold((l) => l, (r) => r);
  }

  // Add a book to favorites
  Future<dynamic> addFavoriteBook(int id) async {
    String accessToken = await tokenManager.accessToken;
    String url = '${AppLink.server}/books/$id/add-to-favorite';
    var response = await crud.postDataWithToken(url, accessToken);
    return response.fold((l) => l, (r) => r);
  }
}
