import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/app_pages.dart';
import 'package:storeapp/core/colors.dart';

logout() => Get.defaultDialog(
      title: 'logout'.tr,
      titleStyle: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 17,
        color: Colors.black,
      ),
      content: Text(
        'are_you_sure_logout'.tr,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
          color: Colors.black,
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          GetStorage().remove('access');
          GetStorage().remove('refresh');
          Get.offAllNamed(Routes.LOGIN);
        },
        child: Text(
          'ok'.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(
                color: AppColors.red,
              ),
            ),
          ),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
         Navigator.pop(Get.overlayContext!, true);
        },
        child: Text(
          'cancel'.tr,
          style: TextStyle(
            color: AppColors.red,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(
                color: AppColors.red,
              ),
            ),
          ),
        ),
      ),
    );
