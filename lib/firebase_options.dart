// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

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
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCsyYIqD5zFPx3ue3FPF0z9cLWbjobSdrY',
    appId: 'com.practical.quizsample',
    messagingSenderId: '',
    projectId: 'quiz-demo-ab9fc',
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
