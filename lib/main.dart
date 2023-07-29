import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'controllers/common/theme_controller.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';
import 'screens/data_uploader_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  InitialBinding().dependencies();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: Get.find<ThemeController>().getLightheme(),
      darkTheme: Get.find<ThemeController>().getDarkTheme(),
      themeMode: ThemeMode.system,
      getPages: AppRoutes.pages(),
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
      name: 'quiz-demo',
      options: DefaultFirebaseOptions.currentPlatform,
    );
}

// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initFireBase();
//   runApp(GetMaterialApp(
//     home: DataUploaderScreen(),
//   ));
// }
