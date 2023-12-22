import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/store_management/models/suppliers_request_model.dart';
import 'package:storeapp/store_management/models/suppliers_response_model.dart';

class SuppliersProvider extends GetConnect {
  Future<Either<List<SuppliersResponseModel>, String?>> getSuppliers() async {
    try {
      final response = await get(API.suppliersURL, headers: {
        'Authorization': 'Bearer ' + GetStorage().read('access'),
      });
      if (response.status.isOk) {
        Iterable l = response.body;

        List<SuppliersResponseModel> res = List<SuppliersResponseModel>.from(
            l.map((model) => SuppliersResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }


     Future<Either<String?, String?>> deleteSupplier(id) async {
    try {
      final response = await delete(
      API.updateSupplier +'${id}/',
      );
      if (response.statusCode == 204) {
        print(response.body);

        return Left('supplier_deleted_successfully'.tr);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  } 

  Future<Either<SuppliersResponseModel, String?>> addSupplier(
      SuppliersRequestModel request) async {
    try {
      final response = await post(
        API.suppliersURL,
        request.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.status.isOk) {
        return Left(SuppliersResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<SuppliersResponseModel, String?>> editSupplier(
      SuppliersResponseModel supplier) async {
    try {
      final response = await put(
        API.updateSupplier +'${supplier.id}/',
        supplier.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.status.isOk) {
        return Left(SuppliersResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }




}
