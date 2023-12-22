import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/widgets/add_input_invoice_dialog.dart';
import 'package:storeapp/store_management/views/widgets/add_input_invoice_dialog_2.dart';
import 'package:storeapp/store_management/views/widgets/serach_products_dialog.dart';

class AddInputsInvoiceScreen extends StatelessWidget {
  AddInputsInvoiceScreen({super.key});
  final StoreManagementController controller =
      Get.put(StoreManagementController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'add_invoice_input'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Row(
                    children: [
                      Text(
                        'add_products'.tr,
                        style: TextStyle(
                          color: AppColors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: InkWell(
                        onTap: () {
                          searchProductsDialog(context, controller);
                        },
                        child: AbsorbPointer(
                          absorbing: true,
                          child: CustomTextField(
                            controller: controller.searchBarcode,
                            hint: 'search_product_name'.tr,
                            isPassword: false,
                            prefixIcon: null,
                            suffixIcon: null,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.07,
                    ),
                    InkWell(
                      onTap: () async {
                        String barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                          '#FF3758',
                          'cancel'.tr,
                          true,
                          ScanMode.BARCODE,
                        );
                        controller.searchBarcode?.text = barcodeScanRes;
                      },
                      child: Image.asset(
                        AppImages.bacode,
                        color: AppColors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: AppColors.pink,
                    child: Center(
                      child: Row(
                        children: controller.inputsProduct.isEmpty
                            ? [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8, right: 8),
                                  child: Icon(
                                    Icons.warning,
                                    color: AppColors.red,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'no_products_added'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.brown,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ]
                            : [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'number'.tr,
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
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'product_name'.tr,
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
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'units_count'.tr,
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
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'unit_price'.tr,
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
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'quantity'.tr,
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
                                      MediaQuery.of(context).size.width * 0.15,
                                  child: Text(
                                    'price'.tr,
                                    textAlign: TextAlign.center,
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
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.32,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: AnimationLimiter(
                    child: ListView.separated(
                      itemCount: controller.inputsProduct.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: InkWell( 
                                onTap: (){
                                  addInputInvoiceDialog(
                                  context, controller.inputsProduct[index] , controller);
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].id}',
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: null,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].product}',
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
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
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].numPerItem}',
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].salePrice}',
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].numItem}',
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                      child: Text(
                                        '${controller.inputsProduct[index].totalPrice}',
                                        overflow: TextOverflow.fade,
                                        softWrap: true,
                                        maxLines: null,
                                        textAlign: TextAlign.center,
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
                ),
                SizedBox(
                  height: 30,
                ),
                !controller.inputsProduct.isEmpty
                    ? Row(
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
                                height: 10,
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
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  width: 216,
                  child: controller.inputsProduct.length == 0 ? SizedBox.shrink() : ElevatedButton(
                    onPressed: () {
                      addInputInvoiceDialog2(context, controller);
                    },
                    child: Text(
                      'confirm'.tr,
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
          )),
    );
  }
}
