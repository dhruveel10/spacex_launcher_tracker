// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        return macos;
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
    apiKey: 'API_KEY',
    appId: '1:853287149350:web:ea6f0bf910bc6c0f4debe7',
    messagingSenderId: '853287149350',
    projectId: 'spacex-launches-fadfc',
    authDomain: 'spacex-launches-fadfc.firebaseapp.com',
    storageBucket: 'spacex-launches-fadfc.appspot.com',
    measurementId: 'G-DBLRF40TCY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'API_KEY',
    appId: '1:853287149350:android:61aa87a53f1ae8304debe7',
    messagingSenderId: '853287149350',
    projectId: 'spacex-launches-fadfc',
    storageBucket: 'spacex-launches-fadfc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'API_KEY',
    appId: '1:853287149350:ios:1958a8e1171a9ea54debe7',
    messagingSenderId: '853287149350',
    projectId: 'spacex-launches-fadfc',
    storageBucket: 'spacex-launches-fadfc.appspot.com',
    iosBundleId: 'com.example.spacexLauncherTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'API_KEY',
    appId: '1:853287149350:ios:ca03adc3c5055d714debe7',
    messagingSenderId: '853287149350',
    projectId: 'spacex-launches-fadfc',
    storageBucket: 'spacex-launches-fadfc.appspot.com',
    iosBundleId: 'com.example.spacexLauncherTracker.RunnerTests',
  );
}
