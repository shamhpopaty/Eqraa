import '../../../../core/class/crud.dart';
import '../../../../linkapi.dart';

class VerifyCodeData {
  Crud crud;
  VerifyCodeData(this.crud);

  postdata(String code) async {
    var response = await crud.postData(AppLink.verifyCodePassword, {
      "code": code,
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
