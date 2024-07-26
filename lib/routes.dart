import 'package:eqraa/presentation/Auth/view/signup.dart';
import 'package:eqraa/presentation/My_Profile/view/my_profile.dart';
import 'package:eqraa/presentation/booksScreen/view/books_screen.dart';
import 'package:eqraa/presentation/description_books/view/desc_books.dart';
import 'package:eqraa/presentation/forgot_password/screens/forgotpassword.dart';
import 'package:eqraa/presentation/forgot_password/screens/resetpassword.dart';
import 'package:eqraa/presentation/forgot_password/screens/successresetpassword.dart';
import 'package:eqraa/presentation/forgot_password/screens/verifycode.dart';
import 'package:eqraa/presentation/show_book/view/show_book.dart';
import 'package:eqraa/widgets/custom_editing_profile.dart';
import 'package:get/get.dart';
import 'package:eqraa/presentation/Auth/view/login.dart';
import 'package:eqraa/presentation/on_boarding/onboarding.dart';
import 'core/middleware/mymiddleware.dart';
import 'presentation/homeScreens/home_screen.dart';
import 'presentation/splash_screen/binding/splash_binding.dart';
import 'presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String onBoarding = '/onBoarding';
  static const String language = '/language';
  static const String forgotPassword = '/forgotPassword';
  static const String splashScreen = '/splashScreen';
  static const String homePage = '/homePage';
  static const String verifyCode = '/verifyCode';
  static const String resetPassword = '/resetPassword';
  static const String successResetPassword = '/successResetPassword';
  static const String myprofile = '/myprofile';
  static const String editigprofile = '/editingprofile';
  static const String showbook = '/showbook';
  static const String descriptionbook = '/descriptionbook';
  static const String bookscreen = '/bookscreen';


  //------------
  static const String notification = '/notification';
}

List<GetPage<dynamic>>? routes = [
  //Main Page
  GetPage(
    name: "/",
    page: () => const SplashScreen(),
    binding: SplashBinding(),
  ),
  //Auth
  GetPage(
    name: AppRoutes.login,
    page: () => const HomeScreen(),
    // page: () => const Login(),
  ),
  GetPage(
    name: AppRoutes.signUp,
    page: () => const SignUp(),
  ),
  //HomePage
  GetPage(name: AppRoutes.homePage, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.resetPassword, page: () => const ResetPassword ()),
  GetPage(name: AppRoutes.successResetPassword, page: () => const SuccessResetPassword ()),
    GetPage(name: AppRoutes.verifyCode, page: () => const VerifyCode ()),
  GetPage(name: AppRoutes.forgotPassword, page: () => const ForgotPassword ()),
  GetPage(name: AppRoutes.myprofile, page: () => const MyProfile ()),
  GetPage(name: AppRoutes.editigprofile, page: () =>  EditProfile ()),
  //GetPage(name: AppRoutes.showbook, page: () =>   ShowBook (pdfPath: '',)),
  GetPage(name: AppRoutes.descriptionbook, page: () =>   Description_Books ()),
  GetPage(name: AppRoutes.bookscreen, page: () =>   Books_Screen ()),

  GetPage(
      name: AppRoutes.onBoarding,
      page: () => const OnBoarding(),
      middlewares: [MyMiddleware()]
  ),
];

// };





