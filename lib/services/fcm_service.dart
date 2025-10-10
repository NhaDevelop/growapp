import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/services/fcm_background_handler.dart';
import 'package:grow_tokyo_app/services/local_notification_service.dart';
import 'package:nb_utils/nb_utils.dart';

// Firebase Messaging instance
FirebaseMessaging? _firebaseMessaging;
bool _isFirebaseMessagingAvailable = false;

class FCMService {
  /// Initialize FCM and get token
  static Future<void> initializeFCM() async {
    try {
      log('🚀 Initializing Firebase Cloud Messaging...');
      
      // Initialize Firebase Messaging
      _firebaseMessaging = FirebaseMessaging.instance;
      _isFirebaseMessagingAvailable = true;
      
      log('✅ Firebase Messaging instance created successfully');

      // Initialize local notifications
      await LocalNotificationService.initialize();
      await LocalNotificationService.createNotificationChannel();
      await LocalNotificationService.requestPermissions();

      // Request permission for notifications
      NotificationSettings settings = await _firebaseMessaging!.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      log('📱 Notification permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        log('✅ User granted notification permission');
        
        // Get the FCM token
        String? token = await _firebaseMessaging!.getToken();
        if (token != null) {
          log('🔥 Real FCM Token received: ${token.substring(0, 50)}...');
          await saveFCMToken(token);
        } else {
          log('❌ Failed to get FCM token');
        }

        // Listen for token refresh
        FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
          log('🔄 FCM Token refreshed: ${token.substring(0, 50)}...');
          saveFCMToken(token);
        });

        // Setup message handlers
        setupMessageHandlers();

      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        log('⚠️ User granted provisional permission');
        // Still try to get token for provisional permission
        String? token = await _firebaseMessaging!.getToken();
        if (token != null) {
          log('🔥 Real FCM Token (provisional): ${token.substring(0, 50)}...');
          await saveFCMToken(token);
        }
      } else {
        log('❌ User declined notification permission');
        // Even without permission, we can still get a token for silent notifications
        String? token = await _firebaseMessaging!.getToken();
        if (token != null) {
          log('🔥 Real FCM Token (no permission): ${token.substring(0, 50)}...');
          await saveFCMToken(token);
        }
      }
    } catch (e) {
      log('❌ Error initializing FCM: $e');
      _isFirebaseMessagingAvailable = false;
      
      // DO NOT generate fake tokens - let the app handle the error
      log('⚠️ FCM initialization failed - no token will be generated');
      log('🔧 Please check Firebase configuration and permissions');
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
      // Force re-initialize if not available
      if (!_isFirebaseMessagingAvailable || _firebaseMessaging == null) {
        log('🔄 Firebase Messaging not initialized - attempting to initialize...');
        await initializeFCM();
      }
      
      // Try to get real FCM token
      if (_isFirebaseMessagingAvailable && _firebaseMessaging != null) {
        String? token = await _firebaseMessaging!.getToken();
        if (token != null && token.isNotEmpty) {
          log('🔥 Retrieved real FCM token: ${token.substring(0, 50)}...');
          return token;
        }
      }
      
      // If we have a stored real token, return it
      String storedToken = userStore.fcmToken;
      if (storedToken.isNotEmpty && !storedToken.startsWith('fake_fcm_token_')) {
        log('💾 Using stored real FCM token: ${storedToken.substring(0, 50)}...');
        return storedToken;
      }
      
      log('❌ No real FCM token available');
      return null;
    } catch (e) {
      log('❌ Error getting FCM token: $e');
      
      // Only return stored token if it's a real token
      String storedToken = userStore.fcmToken;
      if (storedToken.isNotEmpty && !storedToken.startsWith('fake_fcm_token_')) {
        log('💾 Returning stored real token as fallback');
        return storedToken;
      }
      
      return null;
    }
  }

  /// Setup message handlers
  static void setupMessageHandlers() {
    try {
      if (!_isFirebaseMessagingAvailable || _firebaseMessaging == null) {
        log('Firebase Messaging not available for message handlers');
        return;
      }

      log('📨 Setting up Firebase message handlers...');

      // Handle messages when app is in foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        log('📨 Got a message whilst in the foreground!');
        log('📝 Message data: ${message.data}');

        if (message.notification != null) {
          log('🔔 Message notification: ${message.notification!.title} - ${message.notification!.body}');
          
          // Show local notification in notification bar (even when app is open)
          await LocalNotificationService.showNotificationFromFirebase(message);
        }
      });

      // Handle messages when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('🚀 App opened from background message!');
        log('📝 Message data: ${message.data}');
        // Handle navigation based on message data
        _handleMessageNavigation(message);
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      
      log('✅ Firebase message handlers setup complete');
    } catch (e) {
      log('❌ Error setting up message handlers: $e');
    }
  }



  /// Handle navigation when message is tapped
  static void _handleMessageNavigation(RemoteMessage message) {
    try {
      // Handle navigation based on message data
      Map<String, dynamic> data = message.data;
      
      if (data.containsKey('screen')) {
        String screen = data['screen'];
        log('🧭 Navigation to screen: $screen');
        
        // Add your navigation logic here
        // For example:
        // if (screen == 'booking') {
        //   navigatorKey.currentState?.pushNamed('/booking');
        // }
      }
    } catch (e) {
      log('❌ Error handling message navigation: $e');
    }
  }



  /// Check if FCM is available
  static bool isAvailable() {
    return _isFirebaseMessagingAvailable;
  }

  /// Clear any existing fake tokens from storage
  static Future<void> clearFakeTokens() async {
    String currentToken = userStore.fcmToken;
    if (currentToken.startsWith('fake_fcm_token_')) {
      log('🧹 Clearing fake token from storage');
      await userStore.setFcmToken('');
    }
  }

  /// Test function to get and verify real FCM token
  static Future<void> testRealTokenGeneration() async {
    log('=== TESTING REAL FCM TOKEN GENERATION ===');
    
    try {
      // Initialize FCM if not already done
      if (!_isFirebaseMessagingAvailable) {
        await initializeFCM();
      }
      
      String? realToken = await getCurrentToken();
      if (realToken != null) {
        log('✅ Real FCM token retrieved: ${realToken.substring(0, 50)}...');
        log('💾 Token saved to UserStore: ${userStore.fcmToken.isNotEmpty}');
        
        // Try to send to server
        if (appStore.isLoggedIn) {
          try {
            await updateFcmTokenOnServer(realToken);
            log('✅ Real token sent to server successfully');
          } catch (e) {
            log('❌ Failed to send real token to server: $e');
          }
        } else {
          log('⚠️ User not logged in - cannot send token to server');
        }
      } else {
        log('❌ Failed to get real FCM token');
      }
    } catch (e) {
      log('❌ Error in real token test: $e');
    }
    
    log('=== REAL TOKEN TEST COMPLETE ===');
  }

  /// Force refresh and send real FCM token
  static Future<void> forceRefreshAndSendRealToken() async {
    if (!appStore.isLoggedIn) {
      log('⚠️ User not logged in - cannot refresh token');
      return;
    }
    
    log('=== FORCE REFRESHING REAL FCM TOKEN ===');
    
    try {
      // Re-initialize FCM to get fresh token
      await initializeFCM();
      
      String? realToken = await getCurrentToken();
      if (realToken != null) {
        log('🔥 Fresh real token: ${realToken.substring(0, 50)}...');
        
        // Save locally
        await userStore.setFcmToken(realToken);
        log('💾 Saved to UserStore: ${userStore.fcmToken.substring(0, 50)}...');
        
        // Send to server
        try {
          await updateFcmToken(fcmToken: realToken);
          log('✅ Real token successfully sent to server!');
        } catch (e) {
          log('❌ Failed to send real token to server: $e');
        }
      } else {
        log('❌ Failed to get fresh real token');
        log('⚠️ No fallback token will be generated - check Firebase configuration');
      }
    } catch (e) {
      log('❌ Error in force refresh: $e');
    }
    
    log('=== FORCE REFRESH COMPLETE ===');
  }

  /// Test local notification
  static Future<void> testLocalNotification() async {
    log('=== TESTING LOCAL NOTIFICATION ===');
    
    try {
      await LocalNotificationService.showTestNotification();
      log('✅ Test local notification sent');
    } catch (e) {
      log('❌ Error testing local notification: $e');
    }
    
    log('=== LOCAL NOTIFICATION TEST COMPLETE ===');
  }
}