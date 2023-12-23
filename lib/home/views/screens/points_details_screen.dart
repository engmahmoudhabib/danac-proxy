import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        child:   Obx(
          () => controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              : Column(
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
                                  '${controller.points.first.number}' + ' ' + 'points'.tr,
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
                                'points_expired'.tr + ' ' + '${controller.points.first.expireDate}'.tr,
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
                  
                  ],
                ),),
      ),
    );
  }
}
