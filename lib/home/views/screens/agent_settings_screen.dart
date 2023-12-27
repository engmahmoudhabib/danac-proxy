
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/views/screens/profile_screen.dart';
import 'package:storeapp/settings/views/screens/language_screen.dart';
import 'package:storeapp/settings/views/widgets/logout_dialog.dart';


class AgentSettingsScreen extends StatelessWidget {
  const AgentSettingsScreen({super.key});

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
                        print( GetStorage().read('access'));
                        logout();
                      } else if (index == 1) {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: LanguageScreen(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      } else if(index == 0){
                          PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: ProfileScreen(),
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
          );
  }
}