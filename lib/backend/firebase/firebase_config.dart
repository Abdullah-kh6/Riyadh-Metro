import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDCgy6hf41cONTb3vXoV1LDwmJcroBqDjo",
            authDomain: "v2-rg-b1268.firebaseapp.com",
            projectId: "v2-rg-b1268",
            storageBucket: "v2-rg-b1268.firebasestorage.app",
            messagingSenderId: "475011803783",
            appId: "1:475011803783:web:058f61de1fccc8c4362622"));
  } else {
    await Firebase.initializeApp();
  }
}
