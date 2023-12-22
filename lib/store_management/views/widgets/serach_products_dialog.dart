import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';


YYDialog searchProductsDialog(
  BuildContext context,
  StoreManagementController controller,
) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = MediaQuery.of(context).size.height * 0.6
    ..widget(
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'choose_product'.tr,
                  style: TextStyle(
                    color: AppColors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: AppColors.red,
            ),
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: AppColors.red,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.19,
                ),
                Text(
                  'search_product_name'.tr,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(
              color: AppColors.red,
            ),
            SizedBox(
              height: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 42,
                width: MediaQuery.of(context).size.width * 0.75,
                color: AppColors.pink,
                child: Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          'number'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          'name'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          'quantity'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        child: Text(
                          'price'.tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width * 0.75,
              child: AnimationLimiter(
                child: ListView.separated(
                  itemCount: controller.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              controller
                                  .addToMedium(controller.products[index].id);
                                   Navigator.pop(Get.overlayContext!, true);
                            },
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    controller.products[index].id.toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    controller.products[index].name,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    controller.products[index].quantity
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  child: Text(
                                    controller.products[index].purchasingPrice
                                        .toString(),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.black.withOpacity(0.5),
                      endIndent: MediaQuery.of(context).size.width * 0.05,
                      indent: MediaQuery.of(context).size.width * 0.05,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    )
    ..borderRadius = 12
    ..show();
}
