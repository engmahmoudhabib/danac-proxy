import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/points_response_model.dart';

class PointsProvider extends GetConnect {
  Future<Either<List<PointsResponseModel>, String?>> getPoints(id) async {
    try {
      final response = await get(API.pointsURL + '$id');
      if (response.status.isOk) {
        Iterable l = response.body;

        List<PointsResponseModel> res = List<PointsResponseModel>.from(
            l.map((model) => PointsResponseModel.fromJson(model)));
        return Left(res);
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
