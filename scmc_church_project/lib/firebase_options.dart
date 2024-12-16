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
    apiKey: 'AIzaSyBat6Za9mIhj7bXh4YekQ67RzLZeEzaQ48',
    appId: '1:949910384505:web:da23dffd5def04250249a8',
    messagingSenderId: '949910384505',
    projectId: 'scmc-chruch-project',
    authDomain: 'scmc-chruch-project.firebaseapp.com',
    storageBucket: 'scmc-chruch-project.firebasestorage.app',
    measurementId: 'G-3ZVGB4HBGY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6_Zg7HUQwQgraBTlQ3inKyBYiSaPQMNY',
    appId: '1:949910384505:android:ba6d1973d127cb720249a8',
    messagingSenderId: '949910384505',
    projectId: 'scmc-chruch-project',
    storageBucket: 'scmc-chruch-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAqo4NblRgIF76yEL-v6pHA-LpDhgphQM8',
    appId: '1:949910384505:ios:c0c3598ca7de8a430249a8',
    messagingSenderId: '949910384505',
    projectId: 'scmc-chruch-project',
    storageBucket: 'scmc-chruch-project.firebasestorage.app',
    iosBundleId: 'com.church.scmc.scmcChurchProject',
  );
}
