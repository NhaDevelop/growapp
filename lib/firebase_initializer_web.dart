// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  try {
    // Check if firebaseApp exists in the JavaScript context
    if (!js.context.hasProperty('firebaseApp')) {
      print('⚠️ Firebase app not found in JavaScript context');
      return;
    }

    final firebaseApp = js.context['firebaseApp'];
    if (firebaseApp == null) {
      print('⚠️ Firebase app is null');
      return;
    }

    // Safely access options
    final options = firebaseApp['options'];
    if (options == null) {
      print('⚠️ Firebase options are null');
      return;
    }

    // Extract options with null safety
    final apiKey = options['apiKey'];
    final appId = options['appId'];
    final messagingSenderId = options['messagingSenderId'];
    final projectId = options['projectId'];
    final measurementId = options['measurementId'];
    final authDomain = options['authDomain'];
    final storageBucket = options['storageBucket'];

    // Validate required fields
    if (apiKey == null ||
        appId == null ||
        messagingSenderId == null ||
        projectId == null) {
      print('⚠️ Missing required Firebase configuration fields');
      return;
    }

    // Initialize Firebase with validated options
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey.toString(),
        appId: appId.toString(),
        messagingSenderId: messagingSenderId.toString(),
        projectId: projectId.toString(),
        measurementId: measurementId?.toString(),
        authDomain: authDomain?.toString(),
        storageBucket: storageBucket?.toString(),
      ),
    );

    print('✅ Firebase initialized successfully for web');
  } catch (e, stackTrace) {
    // Catch any errors during initialization to prevent app crashes
    print('❌ Error initializing Firebase on web: $e');
    print('Stack trace: $stackTrace');
    // Don't rethrow - allow the app to continue even if Firebase fails
  }
}
