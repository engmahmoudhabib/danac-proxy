import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/splash/models/refresh_request_model.dart';
import 'package:storeapp/splash/models/refresh_response_model.dart';

class SplashProvider extends GetConnect {
  Future<Either<RefreshTokenResponseModel, String?>> refreshToken(
      RefreshTokenRequestModel request) async {
    try {
      final response = await post(
        API.refreshTokenURL,
        request.toJson(),
      );
      if (response.status.isOk) {
        return Left(RefreshTokenResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.statusText);
      }
    } catch (e) {
      print(e.toString());
      return Right('An error occurred: $e');
    }
  }
}
