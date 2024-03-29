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
    apiKey: 'AIzaSyCn1I5RXVlxZmg3ZeFvkmqL5_9CZdcSH_w',
    appId: '1:1070272537176:web:e1a99aceb7d8e8adb4a02d',
    messagingSenderId: '1070272537176',
    projectId: 'chat-3f011',
    authDomain: 'chat-3f011.firebaseapp.com',
    storageBucket: 'chat-3f011.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_x0VJWv_UWoSFCtzwN7EJE-wtnU3XOgM',
    appId: '1:1070272537176:android:7b2d204c2101416db4a02d',
    messagingSenderId: '1070272537176',
    projectId: 'chat-3f011',
    storageBucket: 'chat-3f011.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd5p07l6dYcwZFLWItzh0HpdOLTaJgyog',
    appId: '1:1070272537176:ios:86d611d0b3bafe85b4a02d',
    messagingSenderId: '1070272537176',
    projectId: 'chat-3f011',
    storageBucket: 'chat-3f011.appspot.com',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCd5p07l6dYcwZFLWItzh0HpdOLTaJgyog',
    appId: '1:1070272537176:ios:59f2d28b4805dbc2b4a02d',
    messagingSenderId: '1070272537176',
    projectId: 'chat-3f011',
    storageBucket: 'chat-3f011.appspot.com',
    iosBundleId: 'com.example.chat.RunnerTests',
  );
}
