import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/login/controller/login_controller.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Column(
              children: [
                FadeInLeft(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(40.0)),
                    ),
                    child: FadeInUp(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.07),
                        child: ListTile(
                          title: Text(
                            'forgot_password'.tr,
                            textDirection: Get.locale!.languageCode == 'ar'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'please_enter_phone'.tr,
                            textDirection: Get.locale!.languageCode == 'ar'
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FadeInDown(
                  child: CustomTextField(
                    controller: controller.phoneController,
                    prefixIcon: null,
                    suffixIcon: null,
                    hint: 'email'.tr,
                    isPassword: false,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                FadeInLeft(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 45,
                    child: controller.isLoading.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.getOTP();
                            },
                            child: Text(
                              'send_code'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
