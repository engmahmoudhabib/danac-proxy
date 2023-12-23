import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/order_response_model.dart';
import 'package:storeapp/home/models/orders_response_model.dart';

class OrderProvider extends GetConnect {
  Future<Either<List<OrdersResponseModel>, String?>> getOrders() async {
    try {
      final response = await get(API.getOrdersURL);
      if (response.status.isOk) {
        Iterable l = response.body;

        List<OrdersResponseModel> res = List<OrdersResponseModel>.from(
            l.map((model) => OrdersResponseModel.fromJson(model)));
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

  Future<Either<OrderResponseModel, String?>> getOrder(id) async {
    try {
      final response = await get(
        API.getOrderURL + '$id/',
      );
      if (response.status.isOk) {
        print(response.body);
        return Left(OrderResponseModel.fromJson(response.body));
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
