// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDPOYxDNg0vH9FAiOCKUEV_2lPgsoEpQ2Y',
    appId: '1:1084563956261:web:ac9e4c61a3e352910a95cc',
    messagingSenderId: '1084563956261',
    projectId: 'treaningfirebase',
    authDomain: 'treaningfirebase.firebaseapp.com',
    storageBucket: 'treaningfirebase.appspot.com',
    measurementId: 'G-N6B034WPYJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWMgVjWpdryaVyvIae3JbSXVFvJZ2ej84',
    appId: '1:1084563956261:android:6c0b3b6c3e9c35df0a95cc',
    messagingSenderId: '1084563956261',
    projectId: 'treaningfirebase',
    storageBucket: 'treaningfirebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOVjI0B1mg_F_bNUQdiz01eysufTl1irc',
    appId: '1:1084563956261:ios:bbb123154b54b3460a95cc',
    messagingSenderId: '1084563956261',
    projectId: 'treaningfirebase',
    storageBucket: 'treaningfirebase.appspot.com',
    iosBundleId: 'com.example.traningfirebase',
  );
}
