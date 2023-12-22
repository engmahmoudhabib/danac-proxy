import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/models/medium_table_response_model.dart';

YYDialog addInputInvoiceDialog(BuildContext context,
    MediumTableResponseModel product, StoreManagementController controller) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = 450
    ..widget(
      Obx(
        
        () => Column(
          children: [
            Container(
              height: 75,
              color: AppColors.red,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      'invoice_number'.tr + ': ' + product.id.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      DateTime.now().toString().substring(
                            0,
                            DateTime.now().toString().indexOf(' '),
                          ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    controller.add(product.id ,product.numItem );
                  },
                  child: controller.isAdd.value == true
                      ? Center(
                          child: CircularProgressIndicator(color: AppColors.red,),
                        )
                      : Container(
                          height: 42,
                          width: 50,
                          color: AppColors.pink,
                          child: Center(
                            child: Text(
                              '+',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                ),
                Container(
                  height: 42,
                  width: 100,
                  color: AppColors.pink,
                  child: Center(
                    child: Text(
                      '${controller.inputsQuantity.value}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                controller.minus(product.id ,product.numItem );
                  },
                  child:controller.isMins.value == true
                      ? Center(
                          child: CircularProgressIndicator(color: AppColors.red,),
                        )
                      : Container(
                    height: 42,
                    width: 50,
                    color: AppColors.pink,
                    child: Center(
                      child: Text(
                        '-',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 216,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      product.product ?? '---',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
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
            SizedBox(
              height: 10,
            ),
            Text(
              'product_name'.tr,
              style: TextStyle(
                color: AppColors.red,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '${product.numPerItem}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'units_count'.tr,
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          '${product.salePrice}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'buy_price'.tr,
                      style: TextStyle(
                        color: AppColors.red,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            controller.inputsProduct.firstWhereOrNull(
                        (element) => element.id == product.id) ==
                    null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.inputsProduct.firstWhereOrNull(
                                        (element) =>
                                            element.id == product.id) ==
                                    null ||
                                controller.inputsQuantity.value < 0) {
                              Navigator.pop(Get.overlayContext!, true);

                              controller.inputsProduct.refresh();
                              controller.inputsQuantity.value = 1;
                            }
                            if (controller.inputsProduct.isEmpty) {
                              controller.totalPrice.value = 1;
                              Navigator.pop(Get.overlayContext!, true);
                            }
                          },
                          child: Text(
                            'add'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(Get.overlayContext!, true);
                          },
                          child: Text(
                            'cancel'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(Get.overlayContext!, true);
                          },
                          child: Text(
                            'done'.tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(AppColors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                  )
          ],
        ),
      ),
    )
    ..borderRadius = 12
    ..show();
}
