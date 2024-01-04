import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlng/latlng.dart';
import 'package:location/location.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/core/local.dart';
import 'package:storeapp/firebase_api.dart';
import 'package:storeapp/home/providers/location_provider.dart';
import 'package:storeapp/login/views/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebasAPI().initNotifications();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GetStorage().write('env', 'driver');

  runApp(
    Phoenix(
      child: const StoreApp(),
    ),
  );
}

class StoreApp extends StatefulWidget {
  const StoreApp({super.key});

  @override
  State<StoreApp> createState() => _StoreAppState();
}

class _StoreAppState extends State<StoreApp> {
  late final AppLifecycleListener _listener;
  bool isWorking = false;
  @override
  void initState() {
    super.initState();
    if (GetStorage().read('env') == 'driver' &&
        GetStorage().read('access') != null) {
      _listener = AppLifecycleListener(
        onStateChange: _onStateChanged,
      );
      setState(() {
        isWorking = true;
      });
      sendMyLocation();
    }
  }

  @override
  void dispose() {
    _listener.dispose();
    setState(() {
      isWorking = false;
    });
    super.dispose();
  }

  void _onStateChanged(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
        _onDetached();
      case AppLifecycleState.resumed:
        _onResumed();
      case AppLifecycleState.inactive:
        _onInactive();
      case AppLifecycleState.hidden:
        _onHidden();
      case AppLifecycleState.paused:
        _onPaused();
    }
  }

  void _onDetached() {
    setState(() {
      if (!isWorking) {
        isWorking = true;
        sendMyLocation();
      }
    });
  }

  void _onResumed() {
    setState(() {
      if (!isWorking) {
        isWorking = true;
        sendMyLocation();
      }
    });
  }

  void _onInactive() {
    setState(() {
      if (!isWorking) {
        isWorking = true;
        sendMyLocation();
      }
    });
  }

  void _onHidden() {
    setState(() {
      if (!isWorking) {
        isWorking = true;
        sendMyLocation();
      }
    });
  }

  void _onPaused() {
    setState(() {
      if (!isWorking) {
        isWorking = true;
        sendMyLocation();
      }
    });
  }

  final LocationProvider _locationProvider = LocationProvider();
  updateLocation(double lat, double lng) async {
    final response = await _locationProvider.updateLocation(lat, lng);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      
    } else if (response.isRight()) {
      print('err');
    }
  }

  void sendMyLocation() {
    const oneSec = Duration(seconds: 10);
    Timer.periodic(oneSec, (Timer t) async {
      Location _location = Location();
      bool? _serviceEnabled;
      PermissionStatus? _permissionGranted;
      LatLng? _currentLatLng;
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
      }
      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
      }
      LocationData _locationData = await _location.getLocation();

      _currentLatLng =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      updateLocation(_currentLatLng.latitude, _currentLatLng.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DANAC DRIVER',
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
