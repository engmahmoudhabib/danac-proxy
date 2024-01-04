import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storeapp/core/api.dart';
import 'package:storeapp/home/models/notifications_response_model.dart';

class NotificationsProvider extends GetConnect {
  Future<Either<List<NotificationsResponseModel>, String?>>
      getNotifications() async {
    try {
      final response = await get(
        API.notificationsURL,
        headers: {
          'Authorization': 'Bearer ' + GetStorage().read('access'),
        },
      );
      if (response.status.isOk) {
        Iterable l = response.body;

        List<NotificationsResponseModel> res =
            List<NotificationsResponseModel>.from(
                l.map((model) => NotificationsResponseModel.fromJson(model)));

        return Left(res);
      } else {
        return Right(response.statusText);
      }
    } catch (e) {
      return Right('An error occurred: $e');
    }
  }
}
