part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const LOGIN = _Paths.LOGIN;
  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const SIGNUP = _Paths.SIGNUP;
}

abstract class _Paths {
  static const LOGIN = '/login';
  static const HOME = '/home';
  static const SPLASH = '/SPLASH';
   static const SIGNUP = '/signup';
}
