import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/login/models/get_otp_response_model.dart';
import 'package:storeapp/login/models/login_request_model.dart';
import 'package:storeapp/login/models/login_response_model.dart';

class LoginProvider extends GetConnect {
  Future<Either<LoginResponseModel, String?>> login(
      String? phone, String? password) async {
    try {
      final response = await post(
        API.loginURL,
        LoginRequestModel(
          password: password,
          phonenumber: phone,
          device: 'android',
          token: GetStorage().read('fcmToken'),
        ).toJson(),
      );

      if (response.status.isOk) {
        return Left(LoginResponseModel.fromJson(response.body));
      } else {
       if(response.body['message_error'][0] == 'this account is not accepted'){
         return Right('this account is not accepted');
       } else
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<GetOTPResponseModel, String?>> getOTPCode(
    String? email,
  ) async {
    try {
      final response = await post(
        API.getOTPURL,
        {
          'email': email,
        },
      );

      if (response.status.isOk) {
        return Left(GetOTPResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }

  Future<Either<GetOTPResponseModel, String?>> sendOTPCode(
    int type,
    String? otp,
  ) async {
    try {
      final response = await post(
       type == 0 ? API.acticateAccountOTP : API.sendOTPURL,
        {
          'code': otp,
        },
      );
      if (response.status.isOk) {
        return Left(GetOTPResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.body);
      }
    } catch (e) {
      print(e.toString());
      return Right(e.toString());
    }
  }

  Future<Either<String?, String?>> updatePassword(
      String? password, String? confirmPassword, String? id) async {
    try {
      final response = await put(API.resetPasswordURL + '$id/', {
        'newpassword': password,
        'password': confirmPassword,
      });

      if (response.status.isOk) {
        return Left('password_changed_successfully'.tr);
      } else {
        print(response.body);
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}
