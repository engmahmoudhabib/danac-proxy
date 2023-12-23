import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';

YYDialog orderSuccessDialog(
  BuildContext context,
) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = 450
    ..widget(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Image.asset(AppImages.success),
          Text(
            'order_successfuly'.tr,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            width: 150,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(Get.overlayContext!, true);
                Navigator.pop(context);
              },
              child: Text(
                'back_to_browse'.tr,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      color: AppColors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
         
        ],
      ),
    )
    ..borderRadius = 12
    ..show();
}
