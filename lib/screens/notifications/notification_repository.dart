import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nb_utils/nb_utils.dart';
import '../../main.dart';
import 'model/notification_model.dart';

//region Notification Api
Future<List<NotificationData>> getNotification(
    {bool markAsRead = false, Function(int)? callBack}) async {
  try {
    // Use CMS API for ALL flavors — staging uses demo CMS, prod uses live CMS
    // Both are accessible via BuildConfig.baseUrl which switches automatically
    log('📨 Fetching notifications from CMS API (${BuildConfig.appFlavor.name})...');

    final response = await http.get(
      Uri.parse('${BuildConfig.baseUrl}${APIEndPoints.notificationList}'),
      headers: buildHeaderTokens(),
    );

    log('📥 CMS API Response Status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      log('🔍 CMS API Response Body (truncated): ${response.body.substring(0, response.body.length.clamp(0, 300))}');

      // CMS API uses 'notification_data' field
      if (jsonData['status'] == true && jsonData['notification_data'] != null) {
        final List<dynamic> notificationsJson = jsonData['notification_data'];
        log('✅ Fetched ${notificationsJson.length} notifications');

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

    // Fallback
    log('⚠️ CMS API failed, returning empty notification list');
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
