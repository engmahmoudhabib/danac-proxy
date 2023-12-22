import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/store_management/controllers/store_management_controller.dart';
import 'package:storeapp/store_management/views/screens/add_client_screen.dart';
import 'package:storeapp/store_management/views/widgets/clients_info_dialog.dart';

class ClientsScreen extends StatelessWidget {
  ClientsScreen({super.key});
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
          'clients'.tr,
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
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Text(
                              'phone'.tr,
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
                    onRefresh: () => controller.getClients(),
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
                                itemCount: controller.clients.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: () {
                                            editClientsDialog(
                                              context,
                                              controller,
                                              controller.clients[index].name,
                                              controller.clients[index].id.toString(),
                                              controller
                                                  .clients[index].phonenumber,
                                              controller
                                                  .clients[index].category,
                                              controller.clients[index].address,
                                              controller.clients[index].notes,
                                              controller
                                                  .clients[index].totalPoints
                                                  .toString(),
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
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1
                                                        : 0,
                                                    right: Get.locale!
                                                                .languageCode !=
                                                            'ar'
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1
                                                        : 0,
                                                  ),
                                                  child: Text(
                                                    controller.clients[index].id
                                                        .toString(),
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
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1
                                                        : 0,
                                                    right: Get.locale!
                                                                .languageCode !=
                                                            'ar'
                                                        ? MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1
                                                        : 0,
                                                  ),
                                                  child: Text(
                                                    controller
                                                        .clients[index].name,
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
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                child: Text(
                                                  controller.clients[index]
                                                      .phonenumber,
                                                  textAlign: TextAlign.center,
                                                  textDirection:
                                                      TextDirection.rtl,
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
                            '${controller.clients.length} ' + 'clts'.tr,
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
                          screen: AddClientsScreen(isEdit: false,),
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
