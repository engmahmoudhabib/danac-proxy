import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/sign_up/providers/sign_up_provider.dart';
import 'package:storeapp/sign_up/views/widgets/set_location_dialog.dart';

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
      final result = response.fold((l) => l, (r) => null);
      GetStorage().write('phone', result?.informationUser?.phonenumber);
      GetStorage().write('access', result?.tokens?.accsess);
      GetStorage().write('refresh', result?.tokens?.refresh);
      GetStorage().write('name', result?.informationUser?.username);
      GetStorage().write('email', result?.informationUser?.email);
      YYDialogDemo(context);
    
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
