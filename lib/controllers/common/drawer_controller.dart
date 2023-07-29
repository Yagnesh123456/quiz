import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz/controllers/auth_controller.dart';


class MyDrawerController extends GetxController {
  Rxn<User?> user = Rxn();


  void signOut() {
    Get.find<AuthController>().signOut();
  }

  void signIn() {
    Get.find<AuthController>().navigateToLogin();
  }


  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

}
