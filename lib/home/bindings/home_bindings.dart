import 'package:get/get.dart';
import 'package:storeapp/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
