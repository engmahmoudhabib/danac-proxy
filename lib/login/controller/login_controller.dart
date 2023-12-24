import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/login/providers/login_provider.dart';

class LoginController extends GetxController {
  final TextEditingController? phoneController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? password1Controller = TextEditingController();
  final TextEditingController? password2Controller = TextEditingController();
  final LoginProvider _loginProvider = LoginProvider();
  RxBool isLoading = false.obs;

  login() async {
    isLoading.value = true;
    final response = await _loginProvider.login(
        phoneController?.text, passwordController?.text);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      GetStorage().write('phone', result?.phonenumber);
      GetStorage().write('access', result?.tokens?.access);
      GetStorage().write('refresh', result?.tokens?.refresh);
      Get.offAllNamed(Routes.HOME);
    } else if (response.isRight()) {
       final result = response.fold((l) => null, (r) => r);
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
    }
    isLoading.value = false;
  }
}
