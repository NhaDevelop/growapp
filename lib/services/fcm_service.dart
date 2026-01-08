import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/screens/dashboard/view/dashboard_screen.dart';
import 'package:grow_tokyo_app/screens/booking/view/booking_detail_screen.dart';
import 'package:grow_tokyo_app/screens/evaluation/evaluation_repository.dart';
import 'package:grow_tokyo_app/screens/evaluation/view/stylist_evaluation_screen.dart';
import 'package:grow_tokyo_app/services/local_notification_service.dart';
import 'package:grow_tokyo_app/screens/notifications/notification_repository.dart';
import 'package:grow_tokyo_app/screens/points/point_repository.dart';
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

      // Initialize local notifications (mobile only)
      if (!kIsWeb) {
        await LocalNotificationService.initialize();
        await LocalNotificationService.createNotificationChannel();
        await LocalNotificationService.requestPermissions();
      }

      // 4. Set Foreground Presentation Options (Crucial for iOS/Android foreground heads-up)
      await _firebaseMessaging!.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      // Request permission for notifications
      NotificationSettings settings =
          await _firebaseMessaging!.requestPermission(
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
        String? token = await _firebaseMessaging!.getToken(
          vapidKey: kIsWeb
              ? "BJiBu-F-vUB6AEU7fKlfU9I4v77ehwO9bM2YATHpmLTo1QZnb8hd6ZScqoqfp2IwT1yHz-xgAGVLN8a9VOIlsJA"
              : null,
        );
        log('🔥 Real FCM Token received: ${token!.substring(0, 50)}...');
        await saveFCMToken(token);

        // Listen for token refresh
        FirebaseMessaging.instance.onTokenRefresh.listen((String token) {
          log('🔄 FCM Token refreshed: ${token.substring(0, 50)}...');
          saveFCMToken(token);
        });

        // Setup message handlers
        setupMessageHandlers();
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        log('⚠️ User granted provisional permission');
        // Still try to get token for provisional permission
        String? token = await _firebaseMessaging!.getToken();
        log('🔥 Real FCM Token (provisional): ${token!.substring(0, 50)}...');
        await saveFCMToken(token);
      } else {
        log('❌ User declined notification permission');
        // Even without permission, we can still get a token for silent notifications
        String? token = await _firebaseMessaging!.getToken();
        log('🔥 Real FCM Token (no permission): ${token!.substring(0, 50)}...');
        await saveFCMToken(token);
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
        if (token!.isNotEmpty) {
          log('🔥 Retrieved real FCM token: ${token.substring(0, 50)}...');
          return token;
        }
      }

      // If we have a stored real token, return it
      String storedToken = userStore.fcmToken;
      if (storedToken.isNotEmpty &&
          !storedToken.startsWith('fake_fcm_token_')) {
        log('💾 Using stored real FCM token: ${storedToken.substring(0, 50)}...');
        return storedToken;
      }

      log('❌ No real FCM token available');
      return null;
    } catch (e) {
      log('❌ Error getting FCM token: $e');

      // Only return stored token if it's a real token
      String storedToken = userStore.fcmToken;
      if (storedToken.isNotEmpty &&
          !storedToken.startsWith('fake_fcm_token_')) {
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

        // 🔍 DEBUG: Check what we received
        log('🔍 [DEBUG] Has notification payload: ${message.notification != null}');
        if (message.notification != null) {
          log('🔍 [DEBUG] Notification title: ${message.notification!.title}');
          log('🔍 [DEBUG] Notification body: ${message.notification!.body}');
          log('🔍 [DEBUG] Notification android: ${message.notification!.android}');
          log('🔍 [DEBUG] Notification apple: ${message.notification!.apple}');
        }
        log('🔍 [DEBUG] Data payload: ${message.data}');

        // Extract title/body from either notification payload or data payload
        final String title = message.notification?.title ??
            message.data['title'] ??
            'New Notification';
        final String body = message.notification?.body ??
            message.data['body'] ??
            'You have a new message';

        log('🔍 [DEBUG] Final title: $title');
        log('🔍 [DEBUG] Final body: $body');

        // ✅ Show notification based on platform
        try {
          if (kIsWeb) {
            // 🌐 WEB: Log to console (browser handles notifications via service worker)
            log('🌐 [WEB FOREGROUND] Notification received');
            log('📋 [WEB] Title: $title');
            log('📋 [WEB] Body: $body');
            log('📋 [WEB] Notification data: ${message.data}');
            log('💡 [WEB] Background notifications handled by firebase-messaging-sw.js');
            log('ℹ️ [WEB] Browser policy: Notifications only show when tab is INACTIVE');
            log('🔔 [WEB] To test: Switch to another tab, then send notification');
          } else {
            // 📱 MOBILE: Show local notification
            log('📱 [MOBILE] Attempting to show local notification...');
            await LocalNotificationService.showNotification(
              title: title,
              body: body,
              payload: message.data.isEmpty ? null : message.data.toString(),
            );
            log('✅ [MOBILE] Foreground notification displayed: $title');
          }
        } catch (e) {
          log('❌ Error showing foreground notification: $e');
          log('❌ Stack trace: ${StackTrace.current}');
        }

        // Handle type-specific actions
        final String? notificationType = message.data['type'];

        if (notificationType == 'point_added') {
          log('🎯 Handling point_added notification - refreshing points');
          getPointsAPI();
        } else if (notificationType != null) {
          log('📨 Received notification type: $notificationType');
        }

        // Refresh unread count so badges update immediately
        try {
          if (appStore.isLoggedIn) {
            await getNotification(
                callBack: (totalCount) =>
                    userStore.setUnreadNotificationCount(totalCount));
          }
        } catch (e) {
          log('⚠️ Error refreshing unread notification count: $e');
        }
      });

      // Handle messages when app is opened from background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        log('🚀 App opened from background message!');
        log('📝 Message data: ${message.data}');
        // Handle navigation based on message data
        _handleMessageNavigation(message);
      });

      // NOTE: Background message handler is registered in main.dart before runApp()
      // This is required by Firebase - it must be a top-level function registered early

      log('✅ Firebase message handlers setup complete');
    } catch (e) {
      log('❌ Error setting up message handlers: $e');
    }
  }

  /// Handle navigation when message is tapped
  static void _handleMessageNavigation(RemoteMessage message) async {
    try {
      // Handle navigation based on message data
      Map<String, dynamic> data = message.data;

      if (data.containsKey('screen') || data.containsKey('notification_type')) {
        String screen = data['screen'] ?? data['notification_type'];
        log('🧭 Navigation to screen: $screen');

        // Navigation Logic for Stylist Evaluation
        if (screen == 'stylist_evaluation' || screen == 'evaluation') {
          try {
            log('🚀 Navigating to Stylist Evaluation Screen');
            log('📥 Fetching evaluation form in user\'s language: ${appStore.selectedLanguageCode}');

            // Get booking ID from notification
            int? bookingId = data.containsKey('booking_id')
                ? int.tryParse(data['booking_id'].toString())
                : null;

            // Fetch evaluation form content dynamically based on language
            final evaluationData = await fetchQuestionnaireContent();

            log('✅ Evaluation form fetched successfully');
            log('   Language: ${appStore.selectedLanguageCode}');
            log('   Booking ID: $bookingId');

            // Navigate to evaluation screen with fetched data
            StylistEvaluationScreen(
              evaluationData: evaluationData,
              bookingId: bookingId,
            ).launch(navigatorKey.currentContext!);
            return;
          } catch (e) {
            log('⚠️ Error fetching/navigating to evaluation screen: $e');
            // Fallback: show error message to user
            toast('Failed to load evaluation form. Please try again later.');
          }
        }

        // Navigation Logic for Booking notifications
        if (screen == 'booking' ||
            screen == 'new_booking' ||
            screen == 'complete_booking') {
          // Check if notification has booking ID
          if (data.containsKey('id') && data['id'] != null) {
            try {
              int bookingId = int.parse(data['id'].toString());
              log('🚀 Navigating to Booking Detail Screen #$bookingId');
              // Navigate directly to specific booking detail

              BookingDetailScreen(bookingId: bookingId)
                  .launch(navigatorKey.currentContext!);
              return;
            } catch (e) {
              log('⚠️ Error parsing booking ID: $e');
            }
          }

          // Fallback: Navigate to booking tab if no ID
          log('🚀 Navigating to Booking tab (no specific ID)');
          DashboardScreen(pageIndex: 1).launch(navigatorKey.currentContext!);
        }
        // Add more navigation cases here as needed
        // else if (screen == 'points' || screen == 'point_added') {
        //   // Navigate to points screen
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
      if (kIsWeb) {
        log('⚠️ [WEB] Local notifications not supported on web platform');
        log('💡 [WEB] Use browser notifications instead (handled by service worker)');
      } else {
        await LocalNotificationService.showTestNotification();
        log('✅ Test local notification sent');
      }
    } catch (e) {
      log('❌ Error testing local notification: $e');
    }

    log('=== LOCAL NOTIFICATION TEST COMPLETE ===');
  }
}
