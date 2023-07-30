// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:get/get.dart';
import 'package:quiz/app/utils/constants.dart';
import 'package:quiz/app/utils/language_constant.dart';



/// Default [FirebaseOptions] for use with your Firebase apps.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {

    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
    }

    throw UnsupportedError(
      LANG_CONST.DEFAULT_FIREBASE_OPTION_ARE_NOT_SUPPORTED.toString().tr,
    );
  }


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: API_KEY,
    appId: APP_ID,
    messagingSenderId: '',
    projectId: PROJECT_ID,
    storageBucket: '',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    storageBucket: '',
    iosClientId: '',
    iosBundleId: '',
  );
}
