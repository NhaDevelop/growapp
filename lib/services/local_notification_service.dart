import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nb_utils/nb_utils.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initialize local notifications
  static Future<void> initialize() async {
    try {
      log('🔔 Initializing Local Notifications...');

      // Android initialization settings
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS initialization settings
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      // Combined initialization settings
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      // Initialize the plugin
      await _notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      log('✅ Local Notifications initialized successfully');
    } catch (e) {
      log('❌ Error initializing local notifications: $e');
    }
  }

  /// Handle notification tap
  static void _onNotificationTapped(NotificationResponse response) {
    log('🔔 Notification tapped: ${response.payload}');
    // Handle notification tap here
    // You can navigate to specific screens based on payload
  }

  /// Show notification in notification bar
  static Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      log('🔔 Showing local notification: $title - $body');

      // Android notification details
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'fcm_channel', // Channel ID
        'FCM Notifications', // Channel name
        channelDescription: 'Firebase Cloud Messaging notifications',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
        enableVibration: true,
        playSound: true,
        icon: '@mipmap/ic_launcher',
      );

      // iOS notification details
      const DarwinNotificationDetails iOSPlatformChannelSpecifics =
          DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      // Combined notification details
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      // Show the notification
      await _notificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000, // Unique ID
        title,
        body,
        platformChannelSpecifics,
        payload: payload,
      );

      log('✅ Local notification shown successfully');
    } catch (e) {
      log('❌ Error showing local notification: $e');
    }
  }

  /// Show notification from Firebase message
  static Future<void> showNotificationFromFirebase(RemoteMessage message) async {
    try {
      String title = message.notification?.title ?? 'New Notification';
      String body = message.notification?.body ?? 'You have a new message';
      
      // Create payload with message data
      String payload = message.data.toString();
      
      await showNotification(
        title: title,
        body: body,
        payload: payload,
      );
      
      log('🔔 Firebase notification converted to local notification');
    } catch (e) {
      log('❌ Error converting Firebase notification: $e');
    }
  }

  /// Request notification permissions (Android 13+)
  static Future<bool> requestPermissions() async {
    try {
      log('🔔 Requesting notification permissions...');
      
      final bool? result = await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
      
      log('✅ Notification permissions result: $result');
      return result ?? false;
    } catch (e) {
      log('❌ Error requesting notification permissions: $e');
      return false;
    }
  }

  /// Create notification channel (Android)
  static Future<void> createNotificationChannel() async {
    try {
      log('🔔 Creating notification channel...');
      
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'fcm_channel', // Channel ID
        'FCM Notifications', // Channel name
        description: 'Firebase Cloud Messaging notifications',
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      
      log('✅ Notification channel created successfully');
    } catch (e) {
      log('❌ Error creating notification channel: $e');
    }
  }

  /// Test notification
  static Future<void> showTestNotification() async {
    await showNotification(
      title: 'Test Notification',
      body: 'This is a test notification from your app!',
      payload: 'test_payload',
    );
  }
}