/*
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
    apiKey: 'AIzaSyAPxNvx6LYQY7itGMQruzv5grp2l67T6F4',
    appId: '1:650133511375:web:5df95fded7a94d7bb36bba',
    messagingSenderId: '650133511375',
    projectId: 'flutterbookz',
    authDomain: 'flutterbookz.firebaseapp.com',
    storageBucket: 'flutterbookz.firebasestorage.app',
    measurementId: 'G-9Y5CCXYSHC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBRuePsQeWGVzalLNYHqEPVPXaoi9Lc9TU',
    appId: '1:650133511375:android:b4de31c2d991d1aeb36bba',
    messagingSenderId: '650133511375',
    projectId: 'flutterbookz',
    storageBucket: 'flutterbookz.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2Wi3k3YSXQpJCmvMlT6V6avV7AJFSAao',
    appId: '1:650133511375:ios:7dc40784e26c0841b36bba',
    messagingSenderId: '650133511375',
    projectId: 'flutterbookz',
    storageBucket: 'flutterbookz.firebasestorage.app',
    iosBundleId: 'io.github.kashifo.flutterBooksApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2Wi3k3YSXQpJCmvMlT6V6avV7AJFSAao',
    appId: '1:650133511375:ios:7dc40784e26c0841b36bba',
    messagingSenderId: '650133511375',
    projectId: 'flutterbookz',
    storageBucket: 'flutterbookz.firebasestorage.app',
    iosBundleId: 'io.github.kashifo.flutterBooksApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAPxNvx6LYQY7itGMQruzv5grp2l67T6F4',
    appId: '1:650133511375:web:e8f9093601b7e465b36bba',
    messagingSenderId: '650133511375',
    projectId: 'flutterbookz',
    authDomain: 'flutterbookz.firebaseapp.com',
    storageBucket: 'flutterbookz.firebasestorage.app',
    measurementId: 'G-M1LP3WEWD4',
  );
}
*/
