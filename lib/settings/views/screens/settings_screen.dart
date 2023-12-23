import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/settings/views/screens/language_screen.dart';
import 'package:storeapp/settings/views/widgets/logout_dialog.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return GetStorage().read('env') != 'agent'
        ? Scaffold(
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
                'Settings'.tr,
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
              child: Container(
                margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      if (index == 2) {
                        logout();
                      } else if (index == 1) {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: LanguageScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      }
                    },
                    leading: index == 0
                        ? FadeInLeft(child: Icon(Icons.person))
                        : index == 1
                            ? FadeInUp(child: Icon(Icons.language_rounded))
                            : index == 2
                                ? FadeInDown(child: Icon(Icons.logout_outlined))
                                : SizedBox.shrink(),
                    title: index == 0
                        ? FadeInRight(
                            child: Text(
                              'profile'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : index == 1
                            ? FadeInLeft(
                                child: Text(
                                  'lang'.tr,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : index == 2
                                ? FadeInUp(
                                    child: Text(
                                      'logout'.tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : null,
                    trailing: index == 2 || index == 0
                        ? FadeInDown(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          )
                        : index == 1
                            ? FadeInRight(
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: Get.locale!.languageCode == 'ar'
                                            ? "arabic".tr
                                            : 'french'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : null,
                  ),
                  separatorBuilder: (context, index) => FadeInLeft(
                    child: Divider(
                      color: AppColors.red,
                      indent: MediaQuery.of(context).size.width * 0.03,
                      endIndent: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ),
                  itemCount: 4,
                ),
              ),
            ),
          )
        : Scaffold(
            body: Obx(
            () => Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Card(
                      elevation: 5,
                      child: Center(
                        child: ListTile(
                          title: Text(
                            'User Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            'mahmoud@gmail.com',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          leading: Container(
                            width: 100,
                            height: 100,
                            child: Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListTile(
                    title: Text(
                      'my_points'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      'my_loyality_points'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: RotationTransition(
                      turns: AlwaysStoppedAnimation(180 / 360),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Divider(
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListTile(
                    title: Text(
                      'my_orders'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      Get.locale!.languageCode == 'ar'
                          ? 'لديك ${controller.orders.length} طلبات مضافة في حسابك'
                          : 'Vous avez ${controller.orders.length} commandes ajoutées à votre compte',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: RotationTransition(
                      turns: AlwaysStoppedAnimation(180 / 360),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Divider(
                    color: AppColors.red,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: ListTile(
                    title: Text(
                      'Settings'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      'settings2'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    trailing: RotationTransition(
                      turns: AlwaysStoppedAnimation(180 / 360),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Divider(
                    color: AppColors.red,
                  ),
                )
              ],
            ),
          ));
  }
}
