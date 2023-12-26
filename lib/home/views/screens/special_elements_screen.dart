// ignore_for_file: must_be_immutable

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/product_details_screen.dart';
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
                                if (barcodeScanRes != '-1') {
                                              controller.searchController
                                                  ?.text = barcodeScanRes;
                                            } else {
                                              controller.searchController
                                                  ?.clear();
                                            }
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
                          height: MediaQuery.of(context).size.height * 0.68,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 10 / 20,
                                children: List.generate(
                                  controller.specialProducts.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 2,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreen(
                                                context,
                                                screen: ProductDetailsScreen(
                                                  productName: controller
                                                      .specialProducts[index]
                                                      .name,
                                                  url: controller
                                                      .specialProducts[index]
                                                      .image,
                                                  details: controller
                                                      .specialProducts[index]
                                                      .description
                                                      .toString(),
                                                  units: controller
                                                      .specialProducts[index]
                                                      .numPerItem
                                                      .toString(),
                                                  cartoon: controller
                                                      .specialProducts[index]
                                                      .itemPerCarton
                                                      .toString(),
                                                  category: controller
                                                      .specialProducts[index]
                                                      .category,
                                                  cartoonPrice: controller
                                                      .specialProducts[index]
                                                      .salePrice
                                                      .toString(),
                                                  id: controller
                                                      .specialProducts[index]
                                                      .id,
                                                ),
                                                withNavBar: true,
                                                pageTransitionAnimation:
                                                    PageTransitionAnimation
                                                        .cupertino,
                                              );
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0),
                                                      child: Image.network(
                                                        controller
                                                            .specialProducts[
                                                                index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  FadeInLeft(
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.29,
                                                      height: 31,
                                                      child: ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          controller
                                                              .specialProducts[
                                                                  index]
                                                              .name,
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
                                                                      AppColors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .red,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                                                child: controller.isAddingToCart
                                                            .value ==
                                                        true
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: AppColors.red,
                                                        ),
                                                      )
                                                    : ElevatedButton(
                                                        onPressed: () {},
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
                                                                      AppColors
                                                                          .red),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              side: BorderSide(
                                                                color: AppColors
                                                                    .red,
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
