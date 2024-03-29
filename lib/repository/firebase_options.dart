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
    apiKey: 'AIzaSyDRM7wKQwoxz_qSgqMm-5rCnvwSTMlkybI',
    appId: '1:883677960725:web:a7504802e2c7db79184c1c',
    messagingSenderId: '883677960725',
    projectId: 'parg-53d35',
    authDomain: 'parg-53d35.firebaseapp.com',
    storageBucket: 'parg-53d35.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDWo-JoKoG5nmbpjWGx7dKva25XmYiLv4M',
    appId: '1:883677960725:android:f9fd10d35c340d77184c1c',
    messagingSenderId: '883677960725',
    projectId: 'parg-53d35',
    storageBucket: 'parg-53d35.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBGdXHZ7HuhPWAfP4QY4WtIChKTtJdeSu0',
    appId: '1:883677960725:ios:c23d0ff8eeb88cdd184c1c',
    messagingSenderId: '883677960725',
    projectId: 'parg-53d35',
    storageBucket: 'parg-53d35.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBGdXHZ7HuhPWAfP4QY4WtIChKTtJdeSu0',
    appId: '1:883677960725:ios:602ddd148b2f7d36184c1c',
    messagingSenderId: '883677960725',
    projectId: 'parg-53d35',
    storageBucket: 'parg-53d35.appspot.com',
    iosBundleId: 'com.example.flutterApplication1.RunnerTests',
  );
}
