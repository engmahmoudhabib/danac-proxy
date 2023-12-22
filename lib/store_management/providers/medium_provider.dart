import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/store_management/models/add_medium_response_model.dart';
import 'package:storeapp/store_management/models/add_to_medium_response_model.dart';
import 'package:storeapp/store_management/models/create_income_request_model.dart';
import 'package:storeapp/store_management/models/create_income_response_model.dart';
import 'package:storeapp/store_management/models/list_income_response_modek.dart';
import 'package:storeapp/store_management/models/medium_table_response_model.dart';

class MediumProvider extends GetConnect {
  Future<Either<AddMediumTableResponseModel, String?>> createMedium() async {
    try {
      final response = await post(API.createMediumURL, {});
      if (response.status.isOk) {
        return Left(AddMediumTableResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<MediumTableResponseModel>, String?>> getMediumTable(
      id) async {
    try {
      final response = await get(
        API.getMediumTable + '$id/',
      );
      if (response.status.isOk) {
        print(response.body);
        Iterable l = response.body;
        List<MediumTableResponseModel> res =
            List<MediumTableResponseModel>.from(
                l.map((model) => MediumTableResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<List<ListIncomeResponseModel>, String?>> getIncomeList() async {
    try {
      final response = await get(
        API.getIncomeListURL,
      );
      if (response.status.isOk) {
        print(response.body);
        Iterable l = response.body;
        List<ListIncomeResponseModel> res = List<ListIncomeResponseModel>.from(
            l.map((model) => ListIncomeResponseModel.fromJson(model)));
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

  Future<Either<AddToMediumResponseModel, String?>> addToMedium(
      medium, product) async {
    try {
      final response = await post(API.addToMediumURL + '$medium/$product/', {});
      if (response.status.isOk) {
        return Left(AddToMediumResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.statusText);
      }
    } catch (e) {
      print(e.toString());
      return Right('An error occurred: $e');
    }
  }

  Future<Either<AddToMediumResponseModel, String?>> add(product) async {
    try {
      final response = await post(API.addItem + '$product/add/', {});
      if (response.status.isOk) {
        return Left(AddToMediumResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.statusText);
      }
    } catch (e) {
      print(e.toString());
      return Right('An error occurred: $e');
    }
  }

  Future<Either<AddToMediumResponseModel, String?>> minus(product) async {
    try {
      final response = await post(API.addItem + '$product/sub/', {});
      if (response.status.isOk) {
        return Left(AddToMediumResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.statusText);
      }
    } catch (e) {
      print(e.toString());
      return Right('An error occurred: $e');
    }
  }

  Future<Either<CreateIncomeResponseModel, String?>> createIncome(
      medium, CreateIncomeRequestModel request) async {
    try {
      final response = await post(
        API.createIncomeURL + '$medium/',
        request.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        print(response.body);
        return Left(CreateIncomeResponseModel.fromJson(response.body));
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
