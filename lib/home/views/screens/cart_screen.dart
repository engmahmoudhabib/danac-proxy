import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

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
          'cartt'.tr,
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
          () => controller.isLoading.value == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: AppColors.red,
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      controller.cartItems.isEmpty
                          ? Center(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height*0.8,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart_outlined,
                                      color: Colors.grey,
                                      size: 80,
                                    ),
                                     Text(
                                'cart_empty'.tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                ),
                              ),
                                  ],
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                'cart_empty'.tr,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 30,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
