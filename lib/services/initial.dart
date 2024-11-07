import 'package:get/get.dart';

import '../controllers/GetUsercontroller.dart';
import '../controllers/LoginController.dart';

initializeControllers() {
  Get.lazyPut(() => GetUserController());
  Get.lazyPut(() => LoginController());
}

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.put(GetUserController());
    Get.put(LoginController());
  }
}
