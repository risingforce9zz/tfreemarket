import 'package:get/get.dart';

import '../pages/login_page.dart';
import '../pages/profile_page.dart';
import '../pages/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => SplashScreen(title: "")),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/profile', page: () => ProfilePage()),
  ];
}