import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/search_products_response_model.dart';
import 'package:storeapp/home/models/special_products_response_model.dart';

class ProductsProvider extends GetConnect {
  Future<Either<List<SpecialProductsResponseModel>, String?>>
      getSpecialProducts() async {
    try {
      final response = await get(API.getSpecialProductsURL);
      if (response.status.isOk) {
        Iterable l = response.body;

        List<SpecialProductsResponseModel> res =
            List<SpecialProductsResponseModel>.from(
                l.map((model) => SpecialProductsResponseModel.fromJson(model)));
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

  Future<Either<List<SearchlProductsResponseModel>, String?>>
      getProductsByNameOrBarcode(name, bool isBarcode) async {
    try {
      final response = await get(isBarcode
          ? API.productsURL + '?barcode=$name'
          : API.productsURL + '?name=$name');
      if (response.status.isOk) {
        Iterable l = response.body;
        List<SearchlProductsResponseModel> res =
            List<SearchlProductsResponseModel>.from(
                l.map((model) => SearchlProductsResponseModel.fromJson(model)));
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
