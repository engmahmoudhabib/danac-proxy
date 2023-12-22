import 'package:get/get.dart';
import 'package:storeapp/home/bindings/home_bindings.dart';
import 'package:storeapp/home/views/screens/parent_screen.dart';
import 'package:storeapp/login/bindings/login_bindings.dart';
import 'package:storeapp/login/views/screens/login_screen.dart';
import 'package:storeapp/sign_up/views/screens/sign_up_screen.dart';
import 'package:storeapp/splash/views/screens/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => ParentScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
    ),
     GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpScreen(),
    ),
  ];
}
