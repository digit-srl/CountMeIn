// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'main.dart';

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
  static FirebaseOptions currentPlatform(AppFlavor flavor) {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if(flavor == AppFlavor.collab){
          return collabAndroid;
        }
        return masterAndroid;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB_Ig_vWGPKgluEIZpZKdOP2cEdA7mnFlM',
    appId: '1:978278535568:web:d13966e3386168ce196315',
    messagingSenderId: '978278535568',
    projectId: 'count-me-in-ef93b',
    authDomain: 'count-me-in-ef93b.firebaseapp.com',
    storageBucket: 'count-me-in-ef93b.appspot.com',
    measurementId: 'G-SKX8GZ1G6Z',
  );

  static const FirebaseOptions collabAndroid = FirebaseOptions(
    apiKey: 'AIzaSyBkpdOX8Tl51noxacQnNqq4AwaQ-SFNvgQ',
    appId: '1:978278535568:android:f8cbdc91f52d78e0196315',
    messagingSenderId: '978278535568',
    projectId: 'count-me-in-ef93b',
    storageBucket: 'count-me-in-ef93b.appspot.com',
  );

  static const FirebaseOptions masterAndroid = FirebaseOptions(
    apiKey: 'AIzaSyBkpdOX8Tl51noxacQnNqq4AwaQ-SFNvgQ',
    appId: '1:978278535568:android:6577574a28385432196315',
    messagingSenderId: '978278535568',
    projectId: 'count-me-in-ef93b',
    storageBucket: 'count-me-in-ef93b.appspot.com',
  );
}
