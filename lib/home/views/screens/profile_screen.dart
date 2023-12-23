import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          'profile'.tr,
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: 100,
              height: 100,
              child: Icon(
                Icons.person,
                size: 70,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('edit_profile_pic'.tr),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 23,
                ),
                title: Text(
                  'name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(color: AppColors.red),
            ) , 
                SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListTile(
                leading: Icon(
                  Icons.add_box_outlined,
                  color: Colors.grey,
                  size: 23,
                ),
                title: Text(
                  'serial',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(color: AppColors.red),
            ) , 
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.grey,
                  size: 23,
                ),
                title: Text(
                  'phone',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(color: AppColors.red),
            ) , 
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Colors.grey,
                  size: 23,
                ),
                title: Text(
                  'password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Divider(color: AppColors.red),
            ) ,  
             SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
            FadeInDown(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.65,
                child: ElevatedButton(
                  onPressed: () {
                 
                  },
                  child: Text(
                    'save'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
            )
          ],
        ),
      ),
    );
  }
}
