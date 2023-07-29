import 'package:get/get.dart';
import 'package:quiz/controllers/controllers.dart';
import 'package:quiz/services/services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() =>  FireBaseStorageService());
  }
}
