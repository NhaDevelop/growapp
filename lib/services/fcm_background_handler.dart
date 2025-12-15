import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';

/// Top-level function to handle background messages
/// This must be a top-level function (not inside a class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("🔥 [BACKGROUND] Message Received! ID: ${message.messageId}");
  print("🔥 [BACKGROUND] Title: ${message.notification?.title}");
  print("🔥 [BACKGROUND] Body: ${message.notification?.body}");
  print("🔥 [BACKGROUND] Data: ${message.data}");

  try {
    // Ensure Firebase is initialized (required for background services)
    await Firebase.initializeApp();
    print("✅ [BACKGROUND] Firebase Initialized");
  } catch (e) {
    print("❌ [BACKGROUND] Initialization Error: $e");
  }

  log('🔄 Handling background message: ${message.messageId}');
  log('📝 Background message data: ${message.data}');

  if (message.notification != null) {
    log('🔔 Background notification: ${message.notification!.title} - ${message.notification!.body}');
  }
}
