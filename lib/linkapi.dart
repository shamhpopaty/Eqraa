class AppLink {
  static const String server = "http://127.0.0.1:8000/api";

  //============Image=============================
  static const String imageStatic = "";

  //============================================
  static const String test = "$server/test.php";

  //***************Auth****************
  static const String signUp = "$server/auth/sign-up";
  static const String verifycode = "$server/auth/email-verify.php";
  static const String signIn = "$server/auth/sign-in.php";
  static const String resend = "$server/auth/resend.php";
  static const String forgotPassword = "$server/auth/forgot-password.php";

  //--------------resetPassword=============
  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword =
      "$server/auth/password-reset.php";
  static const String verifyCodePassword =
      "$server/forgetpassword/verifycode.php";

  //------home-----
  static const String home = "$server/home.php";
}
