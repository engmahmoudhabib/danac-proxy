import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/update_profile_response_model.dart';

class ProfileProvider extends GetConnect {
  Future<Either<UpdateProfileResponseModel?, String?>> updateProfile(
    Uint8List image, String id
  ) async {
    final headers = {
      "content_type":
          'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
    };
    FormData form = new FormData({
      "image": MultipartFile(image, filename: 'aa.jpg'),
    });
    try {
      final response = await put(
        API.updateProfile + id.toString()+'/',
        form,
        headers: headers,
      );
      if (response.status.isOk) {
        return Left(UpdateProfileResponseModel.fromJson(response.body));
      } else {
      
        return Right(response.statusText);
      }
    } catch (e) {
  
      return Right('An error occurred: $e');
    }
  }
}
