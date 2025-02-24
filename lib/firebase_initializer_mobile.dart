import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

Future<void> initializeFirebase() async {
  Firebase.initializeApp().then((value) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  });
}
