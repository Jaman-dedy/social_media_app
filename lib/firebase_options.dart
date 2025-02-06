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
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtLDZHoDNFffkOMZBAi8euttG543sVYzA',
    appId: '1:536236166705:android:14294377371ccaf87e4f10',
    messagingSenderId: '536236166705',
    projectId: 'social-media-app-bd52f',
    storageBucket: 'social-media-app-bd52f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJevxmnkCvBQAtUt0gz3AFV_mWFucU9LA',
    appId: '1:536236166705:ios:9a08f2e14aa4f77b7e4f10',
    messagingSenderId: '536236166705',
    projectId: 'social-media-app-bd52f',
    storageBucket: 'social-media-app-bd52f.firebasestorage.app',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6lM2wyoNihDim6YAB6Fa5CIUMw3YiHBU',
    appId: '1:536236166705:web:1e5de57f779d21a07e4f10',
    messagingSenderId: '536236166705',
    projectId: 'social-media-app-bd52f',
    authDomain: 'social-media-app-bd52f.firebaseapp.com',
    storageBucket: 'social-media-app-bd52f.firebasestorage.app',
    measurementId: 'G-F7RLRL6RDG',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJevxmnkCvBQAtUt0gz3AFV_mWFucU9LA',
    appId: '1:536236166705:ios:9a08f2e14aa4f77b7e4f10',
    messagingSenderId: '536236166705',
    projectId: 'social-media-app-bd52f',
    storageBucket: 'social-media-app-bd52f.firebasestorage.app',
    iosBundleId: 'com.example.socialMediaApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6lM2wyoNihDim6YAB6Fa5CIUMw3YiHBU',
    appId: '1:536236166705:web:9e1e264e9b567afc7e4f10',
    messagingSenderId: '536236166705',
    projectId: 'social-media-app-bd52f',
    authDomain: 'social-media-app-bd52f.firebaseapp.com',
    storageBucket: 'social-media-app-bd52f.firebasestorage.app',
    measurementId: 'G-Q6D8ET7YFY',
  );

}