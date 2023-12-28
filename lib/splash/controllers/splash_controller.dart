import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/splash/providers/splash_provider.dart';
import 'package:storeapp/splash/models/refresh_request_model.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:storeapp/core/app_pages.dart';

class SplashController extends GetxController {
  RxBool isLoading = false.obs;

  final SplashProvider _splashProvider = SplashProvider();
  refreshToken() async {
  
    isLoading.value = true;
    final response = await _splashProvider.refreshToken(
      RefreshTokenRequestModel(
        refresh: GetStorage().read('refresh'),
      ),
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      GetStorage().write('access', result?.access);
      GetStorage().write('refresh', result?.refresh);
      Get.offAllNamed(Routes.HOME);
    } else if (response.isRight()) {
      Get.defaultDialog(
        title: 'error'.tr,
        content: Text(
          'please_try_again'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
      Get.offAllNamed(Routes.LOGIN);
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    refreshToken();
    super.onInit();
  }
}
