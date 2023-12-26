import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/core/images.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class PointsDetailsScreen extends StatelessWidget {
  PointsDetailsScreen({super.key});
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
          'points_details'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Obx(
          () =>  Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 126,
                      width: 300,
                      decoration: BoxDecoration(
                        color: AppColors.pink,
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  '${controller.points.first.number}' +
                                      ' ' +
                                      'points'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 50,
                                child: Image.asset(AppImages.smallPrice),
                              )
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            indent: 20,
                            endIndent: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'points_expired'.tr +
                                    ' ' +
                                    '${controller.points.first.expireDate}'.tr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: DefaultTabController(
                        length: 3,
                        child: new Scaffold(
                          appBar: new AppBar(
                            backgroundColor:
                                const Color.fromRGBO(255, 255, 255, 1),
                            elevation: 0,
                            flexibleSpace: new Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                new TabBar(
                                  indicatorColor: Colors.black,
                                  onTap: (value) {
                                    if (value == 0) {
                                      controller.getMyPoints(GetStorage().read('id'));
                                    } else if (value == 1) {
                                      controller.getUsedPoints(GetStorage().read('id'));
                                    } else if (value == 2) {
                                      controller.getExpiredPoints(GetStorage().read('id'));
                                    }
                                  },
                                  indicatorPadding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                  ),
                                  tabs: [
                                    Text(
                                      'all'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'used'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      'finished'.tr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          body: TabBarView(
                            children: [
                          controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              :    SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.695,
                                width: MediaQuery.of(context).size.width * 0.88,
                                child: AnimationLimiter(
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    shrinkWrap: true,
                                    childAspectRatio: 7 / 5,
                                    children: List.generate(
                                      controller.points.length,
                                      (int index) {
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          columnCount: 1,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: ListTile(
                                                title: Text(
                                                  controller.points[index].date,
                                                ),
                                                subtitle: Text(
                                                  'points_expired'.tr +
                                                      ' ' +
                                                      controller.points[index]
                                                          .expireDate,
                                                ),
                                                trailing: Text(
                                                  '${controller.points[index].number}' +
                                                      ' ' +
                                                      'points'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
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
                            controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              :  SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.695,
                                width: MediaQuery.of(context).size.width * 0.88,
                                child: AnimationLimiter(
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    shrinkWrap: true,
                                    childAspectRatio: 7 / 5,
                                    children: List.generate(
                                      controller.points.length,
                                      (int index) {
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          columnCount: 1,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: ListTile(
                                                title: Text(
                                                  controller.points[index].date,
                                                ),
                                                subtitle: Text(
                                                  'points_expired'.tr +
                                                      ' ' +
                                                      controller.points[index]
                                                          .expireDate,
                                                ),
                                                trailing: Text(
                                                  '${controller.points[index].number}' +
                                                      ' ' +
                                                      'points'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
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
                           controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              :   SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.695,
                                width: MediaQuery.of(context).size.width * 0.88,
                                child: AnimationLimiter(
                                  child: GridView.count(
                                    crossAxisCount: 1,
                                    shrinkWrap: true,
                                    childAspectRatio: 7 / 5,
                                    children: List.generate(
                                      controller.points.length,
                                      (int index) {
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: index,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          columnCount: 1,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                              child: ListTile(
                                                title: Text(
                                                  controller.points[index].date,
                                                ),
                                                subtitle: Text(
                                                  'points_expired'.tr +
                                                      ' ' +
                                                      controller.points[index]
                                                          .expireDate,
                                                ),
                                                trailing: Text(
                                                  '${controller.points[index].number}' +
                                                      ' ' +
                                                      'points'.tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
