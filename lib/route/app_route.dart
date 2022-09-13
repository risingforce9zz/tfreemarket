import 'package:get/get.dart';

import '../pages/forgot_password_page.dart';
import '../pages/forgot_password_verification_page.dart';
import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/select_signin_page.dart';
import '../pages/splash_screen.dart';
import '../pages/registration_page.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    //GetPage(name: '/', page: () => SplashScreen(title: "")),
    GetPage(name: '/', page: () => ForgotPasswordVerificationPage()),
    GetPage(name: '/select-signin', page: () => SelectSignInPage()),
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/forgotpassword', page: () => ForgotPasswordPage()),
    GetPage(
        name: '/forgotpassword-verify',
        page: () => const ForgotPasswordVerificationPage()),
    GetPage(name: '/registration', page: () => RegistrationPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ];
}
