import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/cart_item_response_model.dart';
import 'package:storeapp/home/models/create_cart_response_model.dart';

class CartProvider extends GetConnect {
  Future<Either<CreateCartResponseModel, String?>> createCart(id) async {
    try {
      final response = await post(
        API.createCartURL,
        {'customer': '$id'},
      );

      if (response.status.isOk) {
        print(response.body);
        return Left(CreateCartResponseModel.fromJson(response.body));
      } else {
        return Right(response.body);
      }
    } catch (e) {
      return Right(e.toString());
    }
  }



  Future<Either<List<GetCartItemsResponseModel>, String?>>
      getCartItems(cart) async {
    try {
      final response = await get(API.cartItemsURL+'/$cart');
      if (response.status.isOk) {
        Iterable l = response.body;

        List<GetCartItemsResponseModel> res =
            List<GetCartItemsResponseModel>.from(
                l.map((model) => GetCartItemsResponseModel.fromJson(model)));
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



  Future<Either<String?, String?>> addToCart(user, product) async {
    try {
      final response = await post(API.addToCartURL + '$product/$user/', {});

      if (response.status.isOk) {
        print(response.body);
        return Left("product added successfully");
      } else {
        print(response.body);
        return Right(response.body);
      }
    } catch (e) {
      print(e.toString());
      return Right(e.toString());
    }
  }
}
