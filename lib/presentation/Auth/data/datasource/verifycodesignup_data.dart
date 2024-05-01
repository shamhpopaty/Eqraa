import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class VerifyCodeSignupData {
  Crud crud;
  VerifyCodeSignupData(this.crud);

  postdata(
    String code,
    String email,
  ) async {
    var response = await crud.postData(AppLink.verifycode, {
      "code": code,
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }

  resendData(
    String email,
  ) async {
    var response = await crud.postData(AppLink.resend, {
      "email": email,
    });
    return response.fold((l) => l, (r) => r);
  }
}
