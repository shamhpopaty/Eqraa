import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class ForgotPasswordData {
  Crud crud;
  ForgotPasswordData(this.crud);

  postdata(
    String email,
  ) async {
    var response = await crud.postData(AppLink.forgotPassword, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
