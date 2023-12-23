import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/home/views/screens/order_screen.dart';
import 'package:storeapp/store_management/views/widgets/input_row_item.dart';

// ignore: must_be_immutable
class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});
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
          'my_orders'.tr,
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
        child: Obx(() => controller.isLoading.value == true
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'orders_num'.tr,
                                          style: TextStyle(
                                            color: AppColors.brown,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(
                                          text:
                                              " (${controller.orders.length})",
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
                          height: MediaQuery.of(context).size.height * 0.695,
                          width: MediaQuery.of(context).size.width * 0.88,
                          child: AnimationLimiter(
                            child: GridView.count(
                              crossAxisCount: 1,
                              shrinkWrap: true,
                              childAspectRatio: 7 / 5,
                              children: List.generate(
                                controller.orders.length,
                                (int index) {
                                  return AnimationConfiguration.staggeredGrid(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    columnCount: 1,
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
                                            controller.getOrder(
                                                controller.orders[index].id);
                                            PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: OrderScreen(
                                                orderNum:
                                                    controller.orders[index].id,
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
                                                Padding(
                                                  padding: const EdgeInsets.all(
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
                                                            children: [],
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
                                                                    .orders[
                                                                        index]
                                                                    .deliveryDate,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
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
                                                  text: "order_number".tr,
                                                  total: controller
                                                      .orders[index].id
                                                      .toString(),
                                                ),
                                                inputRowItem(
                                                  text: "products_num".tr,
                                                  total: controller
                                                      .orders[index]
                                                      .products
                                                      .length
                                                      .toString(),
                                                ),
                                                inputRowItem(
                                                  text: "tota".tr,
                                                  total: controller
                                                      .orders[index].total
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
                      ],
                    ),
                    onRefresh: () => controller.getOrders(),
                  )
                ],
              )),
      ),
    );
  }
}
