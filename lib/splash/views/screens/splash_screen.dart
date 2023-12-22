import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';

import '../../controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final SplashController controller = Get.put(
    SplashController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.red,
        ),
      ),
    );
  }
}
