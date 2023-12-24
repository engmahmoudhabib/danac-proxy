import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/core/local.dart';
import 'package:storeapp/login/views/screens/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GetStorage().write('env' , 'driver');
  runApp(Phoenix(child: const StoreApp()));
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      home: LoginScreen(),
      translations: MyLocale(),
      locale: GetStorage().read('lang') != null
          ? Locale(GetStorage().read('lang'),
              GetStorage().read('lang') == 'ar' ? 'AR' : 'FR')
          : Locale('ar', 'AR'),
      theme: ThemeData(fontFamily: 'Tajawal'),
      getPages: AppPages.routes,
      initialRoute:
          GetStorage().read('refresh') != null ? Routes.SPLASH : Routes.LOGIN,
    );
  }
}
