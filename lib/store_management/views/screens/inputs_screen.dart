import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/widgets/input_row_item.dart';

class InputsScreen extends StatefulWidget {
  InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  final StoreManagementController controller =
      Get.put(StoreManagementController());
  @override
  void initState() {
    controller.inputsProduct.clear();
    controller.mediumTableID.value = 0;
    super.initState();
  }

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
          'inputs'.tr,
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
          () => controller.isLoadingCategory.value == true
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.red),
                )
              : Column(
                  children: [
                    RefreshIndicator(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 42,
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: AppColors.pink,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'entries_num'.tr,
                                            style: TextStyle(
                                              color: AppColors.brown,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                " (${controller.incomeList.length})",
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'total'.tr,
                                            style: TextStyle(
                                              color: AppColors.brown,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                " (${controller.totalIncomePrice.value})",
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 0.88,
                            child: AnimationLimiter(
                              child: GridView.count(
                                crossAxisCount: 1,
                                shrinkWrap: true,
                                childAspectRatio: 7 / 5,
                                children: List.generate(
                                  controller.incomeList.length,
                                  (int index) {
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      columnCount: 1,
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: InkWell(
                                            onTap: () {},
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            11.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: controller
                                                                      .incomeList[
                                                                          index]
                                                                      .agent,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          child: RichText(
                                                            textAlign:
                                                                TextAlign.end,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: controller
                                                                      .incomeList[
                                                                          index]
                                                                      .date,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                WidgetSpan(
                                                                  child: Icon(
                                                                    Icons
                                                                        .calendar_month,
                                                                    color: Colors
                                                                        .black,
                                                                    size: 18,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Divider(
                                                    color: Colors.black,
                                                    indent: 10,
                                                    endIndent: 10,
                                                  ),
                                                  inputRowItem(
                                                    text: "invoice_number".tr,
                                                    total: controller
                                                        .incomeList[index].id
                                                        .toString(),
                                                  ),
                                                  inputRowItem(
                                                    text: "products_num".tr,
                                                    total: controller
                                                        .incomeList[index]
                                                        .products
                                                        .length
                                                        .toString(),
                                                  ),
                                                  inputRowItem(
                                                    text: "tota".tr,
                                                    total: controller
                                                        .incomeList[index]
                                                        .remainingAmount
                                                        .toString(),
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
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 50,
                            width: 216,
                            child: controller.isLoading.value == true
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.red,
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      controller.inputsProduct.clear();
                                      controller.mediumTableID.value = 0;
                                      controller.createMedium(context);
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
                                          MaterialStateProperty.all<Color>(
                                              AppColors.red),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
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
                      onRefresh: () => controller.getIncomeList(),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
