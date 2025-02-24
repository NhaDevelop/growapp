// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:firebase_core/firebase_core.dart';

Future<void> initializeFirebase() async {
  final firebaseApp = js.context['firebaseApp'];
  if (firebaseApp == null) {
    return;
  }
  final options = firebaseApp['options'];
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: options['apiKey'],
          appId: options['appId'],
          messagingSenderId: options['messagingSenderId'],
          projectId: options['projectId'],
          measurementId: options['measurementId'],
          authDomain: options['authDomain'],
          storageBucket: options['storageBucket']));
}
