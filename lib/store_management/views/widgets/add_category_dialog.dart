import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';

addCategoryDialog(StoreManagementController controller) => Get.defaultDialog(
      title: 'Add_cat'.tr,
      content: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: controller.categoryName,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'catName'.tr,
                hintMaxLines: 1,
                labelStyle: TextStyle(color: AppColors.red),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.red,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.red,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.red,
                    width: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            controller.isLoadingCategory.value == true
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.red,
                    ),
                  )
                : SizedBox(
                    height: 50,
                    width: 216,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.addCategory();
                      },
                      child: Text(
                        'save'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(AppColors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
          ],
        ),
      ),
    );
