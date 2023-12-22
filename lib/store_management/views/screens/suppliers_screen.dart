import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/screens/add_suppliers_screen.dart';
import 'package:storeapp/store_management/views/widgets/supplier_info_dialog.dart';

class SuppliersScreen extends StatelessWidget {
  SuppliersScreen({super.key});
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
          'suppliers'.tr,
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
          () => Container(
            margin: EdgeInsets.only(
              right: Get.locale!.languageCode == 'ar'
                  ? MediaQuery.of(context).size.width * 0.05
                  : 0,
              left: Get.locale!.languageCode == 'ar'
                  ? 0
                  : MediaQuery.of(context).size.width * 0.05,
            ),
            child: SingleChildScrollView(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Get.locale!.languageCode == 'ar'
                                    ? MediaQuery.of(context).size.width * 0.1
                                    : 0,
                                right: Get.locale!.languageCode != 'ar'
                                    ? MediaQuery.of(context).size.width * 0.1
                                    : 0,
                              ),
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: Get.locale!.languageCode == 'ar'
                                    ? MediaQuery.of(context).size.width * 0.1
                                    : 0,
                                right: Get.locale!.languageCode != 'ar'
                                    ? MediaQuery.of(context).size.width * 0.1
                                    : 0,
                              ),
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Text(
                              'phone'.tr,
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
                  SizedBox(
                    height: 20,
                  ),
                  RefreshIndicator(
                    onRefresh: () => controller.getSuppliers(),
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
                                itemCount: controller.suppliers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
                                            editSupplierDialog(
                                              context,
                                              controller,
                                              controller.suppliers[index].name,
                                              controller.suppliers[index].id.toString(),
                                                controller
                                                          .suppliers[index].phoneNumber,
                                                   controller
                                                          .suppliers[index].companyName, 
                                                           controller
                                                          .suppliers[index].address,          
                                                               controller
                                                          .suppliers[index].info, 
                                                  
                                            );
                                          },
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: Get.locale!
                                                                  .languageCode ==
                                                              'ar'
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : 0,
                                                      right: Get.locale!
                                                                  .languageCode !=
                                                              'ar'
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : 0,
                                                    ),
                                                    child: Text(
                                                      controller
                                                          .suppliers[index].id
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                      left: Get.locale!
                                                                  .languageCode ==
                                                              'ar'
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : 0,
                                                      right: Get.locale!
                                                                  .languageCode !=
                                                              'ar'
                                                          ? MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.1
                                                          : 0,
                                                    ),
                                                    child: Text(
                                                      controller
                                                          .suppliers[index]
                                                          .name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Text(
                                                    controller.suppliers[index]
                                                        .phoneNumber,
                                                    textAlign: TextAlign.center,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ]),
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
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    indent: MediaQuery.of(context).size.width *
                                        0.05,
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
                            '${controller.suppliers.length} ' + 'sups'.tr,
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
                          screen: AddSuppliersScreen(
                            isEdit: false,
                          ),
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
          ),
        ),
      ),
    );
  }
}
