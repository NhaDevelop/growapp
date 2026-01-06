import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'model/notification_model.dart';

//region Notification Api
Future<List<NotificationData>> getNotification(
    {bool markAsRead = false, Function(int)? callBack}) async {
  try {
    // Use CMS API for PRODUCTION, External API for STAGING/TESTING
    final isProduction = BuildConfig.appFlavor == AppFlavor.prod;

    if (isProduction) {
      log('📨 Fetching notifications from CMS API (PRODUCTION)...');

      // Use CMS API for production
      final response = await http.get(
        Uri.parse('${BuildConfig.baseUrl}${APIEndPoints.notificationList}'),
        headers: buildHeaderTokens(),
      );

      log('📥 CMS API Response Status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Log the actual response to debug
        log('🔍 CMS API Response Body: ${response.body}');
        log('🔍 Status field: ${jsonData['status']}');
        log('🔍 Data field: ${jsonData['data']}');

        // CMS API uses 'notification_data' field, not 'data'
        if (jsonData['status'] == true &&
            jsonData['notification_data'] != null) {
          final List<dynamic> notificationsJson = jsonData['notification_data'];
          log('✅ Fetched ${notificationsJson.length} notifications from CMS API');

          List<NotificationData> notifications = notificationsJson
              .map((item) => NotificationData.fromJson(item))
              .toList();

          // Count unread notifications
          int unreadCount = notifications.where((n) => n.readAt == null).length;

          log('📊 Total notifications: ${notifications.length}');
          log('📊 Unread notifications: $unreadCount');

          appStore.setLoading(false);
          callBack?.call(unreadCount);
          notificationListCached = notifications;
          userStore.setUnreadNotificationCount(markAsRead ? 0 : unreadCount);

          return notifications;
        } else {
          log('⚠️ CMS API response check failed:');
          log('   status == true? ${jsonData['status'] == true}');
          log('   notification_data != null? ${jsonData['notification_data'] != null}');
        }
      }

      // Fallback for production
      log('⚠️ CMS API failed, returning empty notification list');
      appStore.setLoading(false);
      callBack?.call(0);
      return [];
    }

    // STAGING/TESTING: Use external API
    log('📨 Fetching notifications from EXTERNAL API (STAGING/TESTING)...');

    // Use correct short_title based on flavor
    final shortTitle = isProduction ? 'cms_hg' : 'd-hair-booking';

    final uri = Uri.parse(APIEndPoints.evaluationBaseUrl).replace(
      queryParameters: {
        'page': 'request',
        'method': 'default_api',
        'request_page': 'get',
        'request_method': 'hair_grow_notification',
        'short_title': shortTitle,
        'user_id': userStore.userId.toString(),
      },
    );

    log('🔗 External API URL: $uri');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer a6f1e9c8b2d44b9f9a1c3a6e4f8d9c2e',
      },
    );

    log('📥 External API Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 1 && jsonData['data'] != null) {
        final List<dynamic> notificationsJson = jsonData['data'];
        log('✅ Fetched ${notificationsJson.length} notifications from EXTERNAL API (STAGING)');

        // Convert external API format to app's NotificationData format
        List<NotificationData> notifications = notificationsJson.map((item) {
          return NotificationData(
            id: item['id'],
            data: NotificationModel(
              subject: item['subject'],
              date: item['date'],
              bookingId: item['booking_id'],
              submitStatus: item['submit_status'],
            ),
            readAt: null,
            createdAt: item['date'],
            updatedAt: item['date'],
          );
        }).toList();

        // Count unread notifications (questionnaires not submitted)
        int unreadCount = notifications.where((n) {
          if (n.data?.subject?.toLowerCase().contains('questionnaire') ??
              false) {
            return n.data?.submitStatus != 1;
          }
          return false;
        }).length;

        log('📊 Total notifications: ${notifications.length}');
        log('📊 Unread questionnaires: $unreadCount');

        appStore.setLoading(false);
        callBack?.call(unreadCount);
        notificationListCached = notifications;
        userStore.setUnreadNotificationCount(markAsRead ? 0 : unreadCount);

        return notifications;
      }
    }

    // Fallback: if API fails, return empty list
    log('⚠️ API failed, returning empty notification list');
    appStore.setLoading(false);
    callBack?.call(0);
    return [];
  } catch (e) {
    log('❌ Error fetching notifications: $e');
    appStore.setLoading(false);
    rethrow;
  }
}

// Fetch notification detail with full booking information
Future<NotificationDetail?> getNotificationDetail(String notificationId) async {
  try {
    log('📨 Fetching notification detail for ID: $notificationId');

    // Use correct short_title based on flavor
    final isProduction = BuildConfig.appFlavor == AppFlavor.prod;
    final shortTitle = isProduction ? 'cms_hg' : 'd-hair-booking';

    final uri = Uri.parse(APIEndPoints.evaluationBaseUrl).replace(
      queryParameters: {
        'page': 'request',
        'method': 'default_api',
        'request_page': 'get',
        'request_method': 'hair_grow_notification_detail',
        'short_title': shortTitle,
        'id': notificationId,
      },
    );

    log('🔗 Detail API URL: $uri');

    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer a6f1e9c8b2d44b9f9a1c3a6e4f8d9c2e',
      },
    );

    log('📥 Detail API Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      if (jsonData['status'] == 1 && jsonData['data'] != null) {
        log('✅ Fetched notification detail successfully');
        return NotificationDetail.fromJson(jsonData['data']);
      }
    }

    log('⚠️ Failed to fetch notification detail');
    return null;
  } catch (e) {
    log('❌ Error fetching notification detail: $e');
    return null;
  }
}
//endregion
