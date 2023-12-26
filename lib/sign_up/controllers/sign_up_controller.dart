import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/sign_up/providers/sign_up_provider.dart';
import 'package:storeapp/sign_up/views/screens/waiting_screen.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? phoneController = TextEditingController();
  final TextEditingController? passwordController = TextEditingController();
  final TextEditingController? emailController = TextEditingController();
  final SignUpProvider _signUpProvider = SignUpProvider();

  signUp(context) async {
    isLoading.value = true;
    final response = await _signUpProvider.signUp(
      nameController?.text,
      phoneController?.text,
      passwordController?.text,
      emailController?.text,
    );
    if (response.isLeft()) {
      Get.offAll(WaitingScreen());
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
    }
    isLoading.value = false;
  }
}
