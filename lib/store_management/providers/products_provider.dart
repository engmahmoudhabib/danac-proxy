import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/store_management/models/add_product_response_model.dart';
import 'package:storeapp/store_management/models/products_response_model.dart';

class ProductsProvider extends GetConnect {
  Future<Either<List<ProductsResponseModel>, String?>> getProducts() async {
    try {
      final response = await get(
        API.productsURL,
      );
      if (response.status.isOk) {
        print(response.body);
        Iterable l = response.body;
        List<ProductsResponseModel> res = List<ProductsResponseModel>.from(
            l.map((model) => ProductsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<String?, String?>> deleteProduct(id) async {
    try {
      final response = await delete(
        API.deleteProductsURL + '$id/',
      );
      if (response.statusCode == 204) {
        print(response.body);

        return Left('product_deleted_successfully'.tr);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<AddProductResponseModel, String?>> editProduct(
      String? name,
    String? description,
    Uint8List? image,
    String? quantity,
    String? barcode,
    String? buyPrice,
    String? salePrice,
    String? itemsPerUnit,
    String? unitsPerCartoon,
    String? limitLess,
    String? limitMore,
    String? category,
    String? notes,
    int? id,
  ) async {
    final headers = {
      "content_type":
          'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
    };

    FormData form = new FormData({
      "name": name,
      "description": description,
      "quantity": quantity,
      "image": image == null ? null : MultipartFile(image, filename: 'aa.jpg'),
      "barcode": barcode,
      "purchasing_price": buyPrice,
      "sale_price": salePrice,
      "num_per_item": itemsPerUnit,
      "item_per_carton": unitsPerCartoon,
      "limit_less": limitLess,
      "limit_more": limitMore,
      "category": category,
      "notes": notes,
    });

    try {
      final response = await put(
        API.deleteProductsURL+'$id/',
        form,
        headers: headers,
      );
      if (response.status.isOk) {
        return Left(AddProductResponseModel.fromJson(response.body));
      } else {
        print(response.body);
        return Right(response.statusText);
      }
    } catch (e) {
      print(e.toString());
      return Right('An error occurred: $e');
    }
  }

  Future<Either<AddProductResponseModel, String?>> createProduct(
    String? name,
    String? description,
    Uint8List image,
    String? quantity,
    String? barcode,
    String? buyPrice,
    String? salePrice,
    String? itemsPerUnit,
    String? unitsPerCartoon,
    String? limitLess,
    String? limitMore,
    String? category,
    String? notes, 
  ) async {
    final headers = {
      "content_type":
          'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW',
    };

    FormData form = new FormData({
      "name": name,
      "description": description,
      "quantity": quantity,
      "image": MultipartFile(image, filename: 'aa.jpg'),
      "barcode": barcode,
      "purchasing_price": buyPrice,
      "sale_price": salePrice,
      "num_per_item": itemsPerUnit,
      "item_per_carton": unitsPerCartoon,
      "limit_less": limitLess,
      "limit_more": limitMore,
      "category": category,
      "notes": notes,
    });

    try {
      final response = await post(
        API.productsURL,
        form,
        headers: headers,
      );
      if (response.status.isOk) {
        return Left(AddProductResponseModel.fromJson(response.body));
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
