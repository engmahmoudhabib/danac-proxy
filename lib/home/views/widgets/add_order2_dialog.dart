
import 'package:animate_do/animate_do.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';
import 'package:storeapp/login/views/widgets/custom_textField.dart';

YYDialog addOrder2Dialog(
  BuildContext context,
  HomeController controller,
) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = 650
    ..widget(
      Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              'select_order_date'.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FadeInRight(
              child: EasyDateTimeLine(
                initialDate: DateTime.now(),
                onDateChange: (selectedDate) {
                  final DateFormat formatter = DateFormat('yyyy-MM-dd');
                  final String formatted = formatter.format(selectedDate);
                  controller.date.value = formatted;
                },
                headerProps: const EasyHeaderProps(
                    monthPickerType: MonthPickerType.switcher,
                    selectedDateFormat: SelectedDateFormat.fullDateDMY,
                    showMonthPicker: true),
                dayProps: const EasyDayProps(
                  dayStructure: DayStructure.dayStrDayNum,
                  activeDayStyle: DayStyle(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffff3758),
                          Color(0xffff3758),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
             width:  MediaQuery.of(context).size.width * 0.65,
              child: FadeInDown(
                child: CustomTextField(
                  controller: controller.clientNameController,
                  prefixIcon: null,
                  suffixIcon: null,
                  hint: 'client_name'.tr,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
             width:  MediaQuery.of(context).size.width * 0.65,
              child: FadeInDown(
                child: CustomTextField(
                  controller: controller.clientPhoneController,
                  prefixIcon: null,
                  suffixIcon: null,
                  hint: 'client_phone'.tr,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.phone,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
              SizedBox(
             width:  MediaQuery.of(context).size.width * 0.65,
              child: FadeInDown(
                child: CustomTextField(
                  controller: controller.clientAddressController,
                  prefixIcon: null,
                  suffixIcon: null,
                  hint: 'client_address'.tr,
                  isPassword: false,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FadeInLeft(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
                    child: controller.isLoading.value == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColors.red,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.addOrderToMediumTwo(
                                  context,);
                            },
                            child: Text(
                              'confirm'.tr,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.red),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                ),
                FadeInLeft(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(Get.overlayContext!, true);
                      },
                      child: Text(
                        'cancel'.tr,
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
                ),
              ],
            ),
          ],
        ),
      ),
    )
    ..borderRadius = 12
    ..show();
}
