import 'package:dartz/dartz.dart';
import 'package:eqraa/core/app_export.dart';
import 'package:eqraa/core/services/services.dart';

class AppLink {
MyServices myServices = Get.find();
  static const String ip = "192.168.43.202";
  static const String server = "http://$ip:8000/api";
  static const String baseServer = "http://$ip:8000";


  //============Image=============================
  static const String imageStatic = "";

  //============================================
  static const String test = "$server/test.php";

  //***************Auth****************
  static const String signUp = "$server/users/auth/sign-up";
  static const String verifycode = "$server/users/auth/email-verify";
  static const String signIn = "$server/users/auth/sign-in";
  static const String resend = "$server/users/auth/resend";

  //--------------resetPassword=============
  static const String forgotPassword = "$server/users/auth/forgot-password";

  static const String resetPassword = "$server/users/auth/password-reset";
  static const String verifyCodePassword =
      "$server/users/auth/check-password-reset-code";

  //------home-----
  static const String home = "$server/books/";



  //------showbook-----
  static const String showbook = "$server/";

  //-------descriptionbook----
  static const String descriptionbook = "$server/";

  //-----bookscreen-----
  static const String bookscreen = "$server/books/?category[eq]=";

  static const String notesscreen = "$server/";
static String rateBooks(int id) {
   return "$server/books/$id/rate";
}


  static const String addBookMark = '$server/bookmarks';
  static const String getBookMark='$server/bookmarks';
  static String addFavoriteBook(int id) {
    return '$server/books/$id/add-to-favorite';
  }
  static const String getfavoritebook='$server/books/my-favorite';
  static String removeFavoriteBook(int id) {
    return '$server/books/$id/remove-from-favorite';
  }

  static String saveHighestPage(int id) {
    return '$server/books/$id/read';
  }
  static const String addcomplaints='$server/complaints';
  static const String friends='$server/users/friendship/my-friends';
  static const String sendrequest='$server/users/friendship/send-friend-request';
  static const String recievedrequest='$server/users/friendship/received-friend-requests';
  static const String getbookmarks='$server/bookmarks';
  static String removebookmark(int id) {
    return '$server/bookmarks/$id';
  }
  static String myprofile(int id) {
    return '$server/users/$id';
  }




}
