// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';

class SpecialElementsScreen extends StatelessWidget {
  final int type;
  SpecialElementsScreen({
    super.key,
    required this.type,
  });
  HomeController controller = Get.put(HomeController());
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
          type == 0
              ? 'special_products'.tr
              : type == 1
                  ? 'most_sale_products'.tr
                  : 'new_products'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Icon(
            Icons.shopping_cart,
            color: AppColors.red,
            size: 28,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value == true ||
                controller.isLoadingSearch.value == true
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: CustomTextField(
                          controller: controller.searchController,
                          hint: ''.tr,
                          isPassword: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          onSubmitted: (val) =>
                              controller.getSearchProducts(false),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
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
                            controller.searchController?.text = barcodeScanRes;
                            controller.getSearchProducts(true);
                          },
                          child: Image.asset(
                            AppImages.bacode,
                            color: AppColors.red,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  controller.searchProducts.isEmpty
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: GridView.count(
                            primary: false,
                            crossAxisCount: 3,
                            childAspectRatio: 4 / 5.8,
                            children: List.generate(
                              controller.specialProducts.length,
                              (index) {
                                return Stack(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Image.network(
                                            controller
                                                .specialProducts[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 140,
                                      child: FadeInLeft(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          height: 29,
                                          child: controller
                                                      .isAddingToCart.value ==
                                                  true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColors.red,
                                                  ),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    controller.addToCart(
                                                        controller
                                                            .specialProducts[
                                                                index]
                                                            .id,
                                                        context);
                                                  },
                                                  child: Text(
                                                    'add_to_cart'.tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                AppColors.red),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        side: BorderSide(
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'search_results'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.searchProducts.clear();
                                    controller.searchProducts.refresh();
                                    controller.searchController?.clear();
                                  },
                                  child: Text(
                                    'back'.tr,
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: GridView.count(
                                    primary: false,
                                    crossAxisCount: 3,
                                    childAspectRatio: 4 / 5.8,
                                    children: List.generate(
                                        controller.searchProducts.length,
                                        (index) {
                                      return Stack(
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                child: Image.network(
                                                  controller
                                                      .searchProducts[index]
                                                      .image,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 140,
                                            child: FadeInLeft(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: 29,
                                                child:controller
                                                      .isAddingToCart.value ==
                                                  true
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color: AppColors.red,
                                                  ),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                      controller.addToCart(
                                                        controller
                                                            .specialProducts[
                                                                index]
                                                            .id,
                                                        context);
                                                  },
                                                  child: Text(
                                                    'add_to_cart'.tr,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(
                                                                AppColors.red),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12.0),
                                                        side: BorderSide(
                                                          color: AppColors.red,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
