import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';

chooseImageSourceDialog(StoreManagementController controller , refresh) =>
    Get.defaultDialog(
      title: 'img_src'.tr,
      content: controller.image != null ? SizedBox(
        height: 50,
        width: 216,
        child: ElevatedButton(
          onPressed: () {
            controller.removeImage(refresh);
          },
          child: Text(
            'remove_photo'.tr,
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
      ): SizedBox.shrink(),
      cancel: SizedBox(
        height: 50,
        width: 216,
        child: ElevatedButton(
          onPressed: () {
            controller.pickImageFromGallery(refresh);
          },
          child: Text(
            'gallery'.tr,
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
      ),
      confirm: Column(
        children: [
          SizedBox(
            height: 50,
            width: 216,
            child: ElevatedButton(
              onPressed: () {
                controller.pickImageFromCamera(refresh);
              },
              child: Text(
                'camera'.tr,
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
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
