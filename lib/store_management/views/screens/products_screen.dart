import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/screens/add_product_screen.dart';
import 'package:storeapp/store_management/views/widgets/product_info_dialog.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});
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
          'products'.tr,
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
          () => SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: AppColors.pink,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'number'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'product'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'quantity'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'price'.tr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RefreshIndicator(
                  onRefresh: () => controller.getProducts(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: controller.isLoading.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        : AnimationLimiter(
                            child: ListView.separated(
                              itemCount: controller.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: InkWell(
                                          onTap: () {
                                          
                                            editProductDialog(
                                                context,
                                                controller,
                                                controller.products[index].name,
                                               controller.products[index].category,
                                                controller
                                                    .products[index].image,
                                                controller.products[index]
                                                    .description,
                                                controller
                                                    .products[index].numPerItem
                                                    .toString(),
                                                controller.products[index]
                                                    .itemPerCarton
                                                    .toString(),
                                                controller
                                                    .products[index].quantity
                                                    .toString(),
                                                controller.products[index]
                                                    .purchasingPrice
                                                    .toString(),
                                                controller
                                                    .products[index].salePrice
                                                    .toString() , 
                                                 
                                                     controller
                                                    .products[index].barcode
                                                    .toString() , 
                                                      controller
                                                    .products[index].limitLess.toString(), 
                                                     controller
                                                    .products[index].limitMore.toString(), 
                                                   
                                                     controller
                                                    .products[index].notes, 
                                                   controller
                                                    .products[index].id
                                                    );
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                controller.products[index].id
                                                    .toString(),
                                                textDirection:
                                                    TextDirection.rtl,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              Text(
                                                controller.products[index].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05),
                                              Text(
                                                controller
                                                    .products[index].quantity
                                                    .toString(),
                                                textDirection:
                                                    TextDirection.rtl,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.01),
                                              Text(
                                                controller
                                                    .products[index].salePrice
                                                    .toString(),
                                                textDirection:
                                                    TextDirection.rtl,
                                                maxLines: 1,
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  color: Colors.black.withOpacity(0.5),
                                  endIndent:
                                      MediaQuery.of(context).size.width * 0.05,
                                  indent:
                                      MediaQuery.of(context).size.width * 0.05,
                                );
                              },
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width * 0.4,
                    color: AppColors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${controller.products.length} ' + 'prod'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: 216,
                  child: ElevatedButton(
                    onPressed: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: AddProductScreen(isEdit: false,),
                        withNavBar: true,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
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
          ),
        ),
      ),
    );
  }
}
