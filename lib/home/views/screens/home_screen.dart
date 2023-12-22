import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/store_management/views/screens/store_management_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            FadeInLeft(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  ),
                ),
                child: FadeInUp(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07),
                    child: ListTile(
                      title: Text(
                        'welcome'.tr,
                        textDirection: Get.locale!.languageCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        'time_to_manage'.tr,
                        textDirection: Get.locale!.languageCode == 'ar'
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.68,
              width: MediaQuery.of(context).size.width * 0.95,
              child: AnimationLimiter(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    6,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 2,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: () {
                                if (index == 1) {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: StoreManagementScreen(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                }
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    index == 0
                                        ? Image.asset(AppImages.landSales)
                                        : index == 1
                                            ? Image.asset(AppImages.box)
                                            : index == 2
                                                ? Image.asset(
                                                    AppImages.supplier)
                                                : index == 3
                                                    ? Image.asset(
                                                        AppImages.boxRight)
                                                    : index == 4
                                                        ? Image.asset(
                                                            AppImages.humanHead)
                                                        : Image.asset(AppImages
                                                            .packageDeliveryLogistics),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      index == 0
                                          ? 'hand_buying'.tr
                                          : index == 1
                                              ? 'store_management'.tr
                                              : index == 2
                                                  ? 'driver_client_management'
                                                      .tr
                                                  : index == 3
                                                      ? 'orders_mangement'.tr
                                                      : index == 4
                                                          ? 'human_resources'.tr
                                                          : 'box'.tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        color: Colors.grey,
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
            )
          ],
        ),
      ),
    );
  }
}
