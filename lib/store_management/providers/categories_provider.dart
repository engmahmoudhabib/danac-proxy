import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/store_management/models/add_categories_response_model.dart';
import 'package:storeapp/store_management/models/categories_response_model.dart';

class CategoriesProvider extends GetConnect {
  Future<Either<List<CategoriesResponseModel>, String?>> getCategories() async {
    try {
      final response = await get(API.categoriesURL);
      if (response.status.isOk) {
        Iterable l = response.body;

        List<CategoriesResponseModel> res = List<CategoriesResponseModel>.from(
            l.map((model) => CategoriesResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      
      return Right('An error occurred: $e');
    }
  }

  Future<Either<AddCategoriesResponseModel, String?>> addCategories(
      AddCategoriesRequestModel request) async {
    try {
      final response = await post(
        API.categoriesURL,
        request.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.status.isOk) {
        return Left(AddCategoriesResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }
}
