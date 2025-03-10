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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAlAM58GjjUYf8Y-e3LkU2ZxEf_2h8swHQ',
    appId: '1:438518640585:web:851b18cdca492d7e7c4218',
    messagingSenderId: '438518640585',
    projectId: 'my-ai-learning-app-2cb29',
    authDomain: 'my-ai-learning-app-2cb29.firebaseapp.com',
    storageBucket: 'my-ai-learning-app-2cb29.firebasestorage.app',
    measurementId: 'G-S7TBBDY6NE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDq2VbFY67FhzEx39m-I3rOYPF3Dx5OZuk',
    appId: '1:438518640585:android:59cc3965bf93d1787c4218',
    messagingSenderId: '438518640585',
    projectId: 'my-ai-learning-app-2cb29',
    storageBucket: 'my-ai-learning-app-2cb29.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBjI3FVmz9t8Xc-ry4NUyBERw2NFGnJgnQ',
    appId: '1:438518640585:ios:c7d6e8e96264a4fb7c4218',
    messagingSenderId: '438518640585',
    projectId: 'my-ai-learning-app-2cb29',
    storageBucket: 'my-ai-learning-app-2cb29.firebasestorage.app',
    iosBundleId: 'com.example.nebal',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjI3FVmz9t8Xc-ry4NUyBERw2NFGnJgnQ',
    appId: '1:438518640585:ios:c7d6e8e96264a4fb7c4218',
    messagingSenderId: '438518640585',
    projectId: 'my-ai-learning-app-2cb29',
    storageBucket: 'my-ai-learning-app-2cb29.firebasestorage.app',
    iosBundleId: 'com.example.nebal',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAlAM58GjjUYf8Y-e3LkU2ZxEf_2h8swHQ',
    appId: '1:438518640585:web:ebd5a84d0201f8fc7c4218',
    messagingSenderId: '438518640585',
    projectId: 'my-ai-learning-app-2cb29',
    authDomain: 'my-ai-learning-app-2cb29.firebaseapp.com',
    storageBucket: 'my-ai-learning-app-2cb29.firebasestorage.app',
    measurementId: 'G-YS918C05W0',
  );

}