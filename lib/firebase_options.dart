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
    apiKey: 'AIzaSyA9Fbzu0MZDzHbZy4DBYXu_p5sS9rq4WF4',
    appId: '1:997292287476:web:4a46ce0bb9cb4a0f6705a1',
    messagingSenderId: '997292287476',
    projectId: 'auction-aeb78',
    authDomain: 'auction-aeb78.firebaseapp.com',
    storageBucket: 'auction-aeb78.appspot.com',
    measurementId: 'G-BKM9WG6ZDY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBjaI7aUkTa9ziMU7z5KQCG3zjmmO3xyW8',
    appId: '1:997292287476:android:5e170cfa3de0e38b6705a1',
    messagingSenderId: '997292287476',
    projectId: 'auction-aeb78',
    storageBucket: 'auction-aeb78.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDqb10MlYo2eVcHBnhE-biEcU3NqO7oCg',
    appId: '1:997292287476:ios:4eaa0c738635edd46705a1',
    messagingSenderId: '997292287476',
    projectId: 'auction-aeb78',
    storageBucket: 'auction-aeb78.appspot.com',
    iosClientId: '997292287476-iaas3ko9a0b6ave5ub3iacun8qjh9d00.apps.googleusercontent.com',
    iosBundleId: 'com.example.auction',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCDqb10MlYo2eVcHBnhE-biEcU3NqO7oCg',
    appId: '1:997292287476:ios:4eaa0c738635edd46705a1',
    messagingSenderId: '997292287476',
    projectId: 'auction-aeb78',
    storageBucket: 'auction-aeb78.appspot.com',
    iosClientId: '997292287476-iaas3ko9a0b6ave5ub3iacun8qjh9d00.apps.googleusercontent.com',
    iosBundleId: 'com.example.auction',
  );
}