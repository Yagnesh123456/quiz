import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz/translations/app_translations.dart';
import 'package:quiz/utils/language_constant.dart';

import 'bindings/initial_binding.dart';
import 'controllers/common/theme_controller.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';

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
      title: LANG_CONST.TITLE.toString().tr,
      theme: Get.find<ThemeController>().getLightheme(),
      darkTheme: Get.find<ThemeController>().getDarkTheme(),
      themeMode: ThemeMode.system,
      getPages: AppRoutes.pages(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('en', 'US'),
      translationsKeys: AppTranslation.translations,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
      name: 'quiz-demo',
      options: DefaultFirebaseOptions.currentPlatform,
    );
}
