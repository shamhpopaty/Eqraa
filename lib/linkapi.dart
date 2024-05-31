class AppLink {

  static const String ip = "localhost";
  static const String server = "http://$ip:8000/api";


  //============Image=============================
  static const String imageStatic = "";

  //============================================
  static const String test = "$server/test.php";

  //***************Auth****************
  static const String signUp = "$server/auth/sign-up";
  static const String verifycode = "$server/auth/email-verify";
  static const String signIn = "$server/auth/sign-in";
  static const String resend = "$server/auth/resend";

  //--------------resetPassword=============
  static const String forgotPassword = "$server/auth/forgot-password";

  static const String resetPassword = "$server/auth/password-reset";
  static const String verifyCodePassword =
      "$server/auth/check-password-reset-code";

  //------home-----
  static const String home = "$server/books/";

  //------profile------
  static const String profile = "$server/";

  //------showbook-----
  static const String showbook = "$server/";

  //-------descriptionbook----
  static const String descriptionbook = "$server/";

  //-----bookscreen-----
  static const String bookscreen = "$server/";


}
