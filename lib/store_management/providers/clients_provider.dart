import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/store_management/models/client_request_model.dart';
import 'package:storeapp/store_management/models/clients_response_model.dart';

class ClientsProvider extends GetConnect {
  Future<Either<List<ClientsResponseModel>, String?>> getClients() async {
    try {
      final response = await get(
        API.clientsURL,
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<ClientsResponseModel> res = List<ClientsResponseModel>.from(
            l.map((model) => ClientsResponseModel.fromJson(model)));
        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<String?, String?>> deleteClient(id) async {
    try {
      final response = await delete(
        API.deleteClientsURL + '${id}/',
      );
      if (response.statusCode == 204) {
   

        return Left('client_deleted_successfully'.tr);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<ClientsResponseModel, String?>> addClient(
      ClientsRequestModel request) async {
    try {
      final response = await post(
        API.clientsURL,
        request.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.status.isOk) {
        return Left(ClientsResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }

  Future<Either<ClientsResponseModel, String?>> editClient(
      ClientsResponseModel client) async {
    try {
      final response = await put(
        API.deleteClientsURL + '${client.id}/',
        client.toJson(),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.status.isOk) {
        return Left(ClientsResponseModel.fromJson(response.body));
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }
}
