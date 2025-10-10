// This file contains the actual FCM implementation
// It should be used once firebase_messaging dependency is added

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:nb_utils/nb_utils.dart';

class FCMServiceImpl {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// Initialize FCM and get token
  static Future<void> initializeFCM() async {
    try {
      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('User granted permission');
        
        // Get the token
        String? token = await _firebaseMessaging.getToken();
        if (token != null) {
          log('FCM Token: $token');
          await saveFCMToken(token);
        }

        // Listen for token refresh
        _firebaseMessaging.onTokenRefresh.listen((String token) {
          log('FCM Token refreshed: $token');
          saveFCMToken(token);
        });

      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('User granted provisional permission');
      } else {
        log('User declined or has not accepted permission');
      }
    } catch (e) {
      log('Error initializing FCM: $e');
    }
  }

  /// Save FCM token to local storage and send to server
  static Future<void> saveFCMToken(String token) async {
    try {
      // Save to local storage
      await userStore.setFcmToken(token);
      
      // Send to server if user is logged in
      if (appStore.isLoggedIn) {
        await updateFcmTokenOnServer(token);
      }
    } catch (e) {
      log('Error saving FCM token: $e');
    }
  }

  /// Update FCM token on server
  static Future<void> updateFcmTokenOnServer(String token) async {
    try {
      if (appStore.isLoggedIn && token.isNotEmpty) {
        await updateFcmToken(fcmToken: token);
        log('FCM token updated on server successfully');
      }
    } catch (e) {
      log('Error updating FCM token on server: $e');
    }
  }

  /// Get current FCM token
  static Future<String?> getCurrentToken() async {
    try {
      return await _firebaseMessaging.getToken();
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  /// Setup message handlers
  static void setupMessageHandlers() {
    // Handle messages when app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log('Message also contained a notification: ${message.notification}');
        // You can show a local notification here if needed
      }
    });

    // Handle messages when app is opened from background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('A new onMessageOpenedApp event was published!');
      log('Message data: ${message.data}');
      // Handle navigation based on message data
    });
  }

  /// Handle background messages (must be top-level function)
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    log('Handling a background message: ${message.messageId}');
  }
}