// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/login/providers/login_provider.dart';
import 'package:storeapp/login/views/screens/login_screen.dart';
import 'package:storeapp/login/views/screens/otp_screen.dart';
import 'package:storeapp/login/views/screens/reset_password_screen.dart';
import 'package:storeapp/sign_up/views/widgets/set_location_dialog.dart';

class LoginController extends GetxController {
  final TextEditingController? phoneController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? password1Controller = TextEditingController();
  final TextEditingController? password2Controller = TextEditingController();
  RxString otp = ''.obs;
  RxString user = ''.obs;
  final LoginProvider _loginProvider = LoginProvider();
  RxBool isLoading = false.obs;

  login() async {
    isLoading.value = true;
    final response = await _loginProvider.login(
        phoneController?.text, passwordController?.text);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      phoneController?.clear();
      passwordController?.clear();
      GetStorage().write('phone', result?.username);
      GetStorage().write('access', result?.tokens?.access);
      GetStorage().write('refresh', result?.tokens?.refresh);
      GetStorage().write('image', result?.images);
        GetStorage().write('id', result?.id);
      Get.offAllNamed(Routes.HOME);
    } else if (response.isRight()) {
      final result = response.fold((l) => null, (r) => r);
      if (result == 'this account is not accepted') {
        Get.to(OTPScreen(
          type: 0,
        ));
      } else {
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
      ;
    }
    isLoading.value = false;
  }

  getOTP() async {
    isLoading.value = true;
    final response = await _loginProvider.getOTPCode(
      phoneController?.text,
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      phoneController?.clear();
      Get.to(OTPScreen(
        type: 1,
      ));
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

  sendOTP(type , context) async {
    isLoading.value = true;
    final response = await _loginProvider.sendOTPCode(
      type,
      otp.value,
    );
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      if (type == 0) {
        accountActivateMsg(context);
      } else {
        Get.to(ResetPasswordScreen());
        user.value = result!.userId.toString();
      }
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

  updatePassword() async {
    isLoading.value = true;
    final response = await _loginProvider.updatePassword(
        password1Controller?.text, password2Controller?.text, user.value);
    if (response.isLeft()) {
      final result = response.fold((l) => l, (r) => null);
      password1Controller?.clear();
      password2Controller?.clear();
      Get.offAll(LoginScreen());
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
