import 'package:get/get.dart';

class FavoriteController extends GetxController {
  var isFavorite = false.obs;

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }
}
