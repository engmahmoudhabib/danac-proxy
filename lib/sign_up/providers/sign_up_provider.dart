import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/sign_up/models/sign_up_request_model.dart';
import 'package:storeapp/sign_up/models/sign_up_response_model.dart';

class SignUpProvider extends GetConnect {
  Future<Either<SignUpResponseModel, String?>> signUp(
      String? name, String? phone, String? password , String? email) async {
    try {
      final response = await post(
        API.signUpURL,
        SignUpRequestModel(
          username: name,
          password: password,
          phonenumber: phone,
          email: email,
        ).toJson(),
      );

      if (response.status.isOk) {
        return Left(SignUpResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }
}
