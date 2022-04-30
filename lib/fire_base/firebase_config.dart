import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (kIsWeb) {
      // Web
      return const FirebaseOptions(
        apiKey: 'AIzaSyBXk4uU9IKcCdmXbFTVwqJZ9WwfNibslNU',
        authDomain: 'fluttertest-59607.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        projectId: 'fluttertest-59607',
        storageBucket: 'fluttertest-59607.appspot.com',
        messagingSenderId: '782955578261',
        appId: '1:782955578261:web:20c1b165db4cb76c53ec9c',
        measurementId: 'G-SMPVGR6V0C',
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      // iOS and MacOS
      return const FirebaseOptions(
        apiKey: 'AIzaSyBXk4uU9IKcCdmXbFTVwqJZ9WwfNibslNU',
        appId: '1:782955578261:web:20c1b165db4cb76c53ec9c',
        messagingSenderId: '782955578261',
        projectId: 'fluttertest-59607',
        authDomain: 'fluttertest-59607.firebaseapp.com',
        iosBundleId: 'io.flutter.plugins.firebase.messaging',
        iosClientId:
        '448618578101-evbjdqq9co9v29pi8jcua8bm7kr4smuu.apps.googleusercontent.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
      );
    } else {
      // Android
      return const FirebaseOptions(
        appId: '1:782955578261:web:20c1b165db4cb76c53ec9c',
        apiKey: 'AIzaSyBXk4uU9IKcCdmXbFTVwqJZ9WwfNibslNU',
        projectId: 'fluttertest-59607',
        messagingSenderId: '782955578261',
        authDomain: 'fluttertest-59607.firebaseapp.com',
        androidClientId:
        '448618578101-sg12d2qin42cpr00f8b0gehs5s7inm0v.apps.googleusercontent.com',
      );
    }
  }
}