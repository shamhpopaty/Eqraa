class AppLink {
  static const String server = "http://192.168.1.106:8000/api";

  //============Image=============================
  static const String imageStatic = "";

  //============================================
  static const String test = "$server/test.php";

  //***************Auth****************
  static const String signUp = "$server/auth/sign-up";
  static const String verifycode = "$server/auth/email-verify";
  static const String signIn = "$server/auth/sign-in";
  static const String resend = "$server/auth/resend";
  static const String forgotPassword = "$server/auth/forgot-password";

  //--------------resetPassword=============
  static const String checkEmail = "$server/forgetpassword/checkemail";
  static const String resetPassword = "$server/auth/password-reset";
  static const String verifyCodePassword = "$server/forgetpassword/verifycode";

  //------home-----
  static const String home = "$server/home";
}
