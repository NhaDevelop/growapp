import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// SUPER SIMPLE FIREBASE DEBUG
/// Just copy this code and paste it anywhere in your app!

void simpleFirebaseDebug() async {
  print('=== FIREBASE DEBUG START ===');
  
  try {
    // Get Firebase project ID
    String projectId = Firebase.app().options.projectId;
    print('🔥 Firebase Project ID: $projectId');

    // Check if correct project
    bool isCorrect = projectId == 'growtokyo-fd8ae';
    print('✅ Using correct project: $isCorrect');

    // Get FCM token
    String? token = await FirebaseMessaging.instance.getToken();
    print('🔑 FCM Token: $token');

    // Show error if wrong project
    if (!isCorrect) {
      print('❌ ERROR: App is using project $projectId but server expects growtokyo-fd8ae');
    }
    
    // Show success if everything is correct
    if (isCorrect) {
      print('🎉 SUCCESS! Everything looks good!');
    }
    
  } catch (e) {
    print('❌ Error: $e');
  }
  
  print('=== FIREBASE DEBUG END ===');
}

/// HOW TO USE:
/// 1. Copy the function above
/// 2. Paste it in your main.dart file
/// 3. Call simpleFirebaseDebug(); anywhere in your app
/// 4. Check the console/logs for output