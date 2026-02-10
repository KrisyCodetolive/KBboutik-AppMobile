import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyCfGTl8_wVQa3tRohadHvBAK7xDPAxyn0M",
      appId: "1:292321260361:android:6a92abc04a4cf8679c2098",
      messagingSenderId: "292321260361",
      projectId: "kbboutikdatabase",
      storageBucket: "kbboutikdatabase.firebasestorage.app",
    );
  }
}