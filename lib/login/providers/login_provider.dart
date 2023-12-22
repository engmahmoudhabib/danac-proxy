import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/login/models/login_request_model.dart';
import 'package:storeapp/login/models/login_response_model.dart';

class LoginProvider extends GetConnect {
  Future<Either<LoginResponseModel, String?>> login(String? phone, String? password) async {
    try {
      final response = await post(
        API.loginURL,
        LoginRequestModel(
          password: password,
          phonenumber: phone,
        ).toJson(),
      );
      
      if (response.status.isOk) {
         print(response.body);
        return Left(LoginResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }
}