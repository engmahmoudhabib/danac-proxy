import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/widgets/add_category_dialog.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});
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
          'categories'.tr,
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
                        mainAxisAlignment: Get.locale!.languageCode == 'ar'
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: Get.locale!.languageCode == 'ar'
                            ? [
                                Text(
                                  'number'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.25,
                                ),
                                Text(
                                  'name'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                ),
                              ]
                            : [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.05,
                                ),
                                Text(
                                  'number'.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      0.13,
                                ),
                                Text(
                                  'name'.tr,
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
                    height: 20,
                  ),
                  RefreshIndicator(
              onRefresh: () => controller.getCategories(),
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
                                itemCount: controller.categoris.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Row(
                                          mainAxisAlignment:
                                              Get.locale!.languageCode == 'ar'
                                                  ? MainAxisAlignment.start
                                                  : MainAxisAlignment.start,
                                          children: Get.locale!.languageCode ==
                                                  'ar'
                                              ? [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                  ),
                                                  Text(
                                                    controller
                                                        .categoris[index].id
                                                        .toString(),
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.28,
                                                  ),
                                                  Text(
                                                    controller
                                                        .categoris[index].name,
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ]
                                              : [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05,
                                                  ),
                                                  Text(
                                                    controller
                                                        .categoris[index].id
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.31,
                                                  ),
                                                  Text(
                                                    controller
                                                        .categoris[index].name,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
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
                            '${controller.categoris.length} ' + 'cats'.tr,
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
                        addCategoryDialog(controller);
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
