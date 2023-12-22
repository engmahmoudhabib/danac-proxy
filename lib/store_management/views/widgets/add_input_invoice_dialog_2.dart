import 'dart:ffi';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';

YYDialog addInputInvoiceDialog2(
    BuildContext context, StoreManagementController controller) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = MediaQuery.of(context).size.height * 0.9
    ..widget(
      Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 45,
                color: AppColors.red,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 48,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(50),
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              dropdownButtonProps: DropdownButtonProps(
                                icon: RotationTransition(
                                  turns: new AlwaysStoppedAnimation(90 / 360),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                ),
                              ),
                              items: controller.supsNames as List<String>,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "suplliers".tr,
                                  hintText: "suplliers".tr,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                ),
                              ),
                              onChanged: (value) {
                                if (value == null) {
                                  controller.sups.value ==
                                      controller.supsNames[0];
                                } else {
                                  controller.sups.value = value;
                                  controller.supplierID.value = int.parse(
                                      controller
                                          .sups.value
                                          .substring(
                                              0,
                                              controller.sups.value
                                                  .indexOf('-'))
                                          .replaceAll(' ', ''));
                                }
                              },
                              selectedItem: controller.supsNames[0],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.proxyName,
                          hint: 'proxy_name'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.proxyTrukNumber,
                          hint: 'proxy_truk_num'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      /*    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        height: 48,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(50),
                          child: DropdownButtonHideUnderline(
                            child: DropdownSearch<String>(
                              popupProps: PopupProps.menu(
                                showSelectedItems: true,
                              ),
                              dropdownButtonProps: DropdownButtonProps(
                                icon: RotationTransition(
                                  turns: new AlwaysStoppedAnimation(90 / 360),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                ),
                              ),
                              items: controller.supsNames as List<String>,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(
                                  labelText: "employee_name".tr,
                                  hintText: "employee_name".tr,
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 20),
                                ),
                              ),
                              onChanged: (value) {
                                if (value == null) {
                                  controller.sups.value ==
                                      controller.supsNames[0];
                                } else {
                                  controller.sups.value = value;
                                }
                              },
                              selectedItem: controller.supsNames[0],
                            ),
                          ),
                        ),
                      ), */
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.invoiceCheckCode,
                          hint: 'ver_invoice_code'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.customerServicePhone,
                          hint: 'customer_service_phone'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.phone,
                        ),
                      ),
                      SizedBox(
                        height: 15,
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
                                    '${controller.inputsProduct.length}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side: BorderSide(
                                          color: AppColors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'products_num'.tr,
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
                                    '${controller.total.value}',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                'tota'.tr,
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
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.paidMoney,
                          hint: 'paid_money'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          onChange: (val) {
                            controller.rmAmt.value =
                                controller.rmAmt.value + double.parse(val);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.discount,
                          hint: 'discount'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          onChange: (val) {
                            controller.rmAmt.value =
                                controller.rmAmt.value - double.parse(val);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.returnProducts,
                          hint: 'returns_products'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          onChange: (val) {
                            controller.rmAmt.value =
                                controller.rmAmt.value - double.parse(val);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: CustomTextField(
                          controller: controller.oldDebts,
                          hint: 'old_debts'.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.number,
                          onChange: (val) {
                            controller.rmAmt.value =
                                controller.rmAmt.value - double.parse(val);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'rem_amt'.tr,
                            style: TextStyle(
                              color: AppColors.red,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "${controller.rmAmt.value}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: controller.isLoading.value == false
                                ? ElevatedButton(
                                    onPressed: () {
                                      controller.createIncome(context);
                                      Navigator.pop(Get.overlayContext!, true);
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
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              AppColors.red),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          side: BorderSide(
                                            color: AppColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.red,
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(Get.overlayContext!, true);
                                controller.total.value = 0.0;
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
                                    MaterialStateProperty.all<Color>(
                                        AppColors.red),
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
            ],
          ),
        ),
      ),
    )
    ..borderRadius = 12
    ..show();
}
