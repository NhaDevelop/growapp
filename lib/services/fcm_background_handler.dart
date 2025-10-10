import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';

/// Top-level function to handle background messages
/// This must be a top-level function (not inside a class)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔄 Handling background message: ${message.messageId}');
  log('📝 Background message data: ${message.data}');
  
  if (message.notification != null) {
    log('🔔 Background notification: ${message.notification!.title} - ${message.notification!.body}');
  }
  
  // You can add custom logic here for background message handling
  // For example, updating local database, showing notifications, etc.
}