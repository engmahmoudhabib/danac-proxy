import 'dart:ffi';

import 'package:animate_do/animate_do.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:intl/intl.dart';
import 'package:storeapp/core/colors.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

YYDialog addOrderDialog(
  BuildContext context,
  HomeController controller,
) {
  return YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width * 0.8
    ..height = 450
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
            FadeInLeft(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: 45,
                child: controller.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          controller.addOrder(context, controller.date.value);
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
            SizedBox(
              height: 20,
            ),
            FadeInLeft(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
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
      ),
    )
    ..borderRadius = 12
    ..show();
}
