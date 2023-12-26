import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:get/get.dart';

import 'package:storeapp/core/images.dart';



YYDialog accountActivateMsg(BuildContext context) {
  return YYDialog().build(context)
    ..width = 327
    ..height = 309
    ..widget(
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Image.asset(AppImages.success),
            SizedBox(
              height: 20,
            ),
            Text(
              'congrats'.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          
          ],
        ),
      ),
    )
    ..show();
}
