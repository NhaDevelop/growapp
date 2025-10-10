import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/services/fcm_service.dart';
import 'package:nb_utils/nb_utils.dart';

class FCMUtils {
  /// Initialize FCM for logged-in users
  static Future<void> initializeForLoggedInUser() async {
    if (appStore.isLoggedIn) {
      try {
        await FCMService.initializeFCM();
        if (!FCMService.isAvailable()) {
          log('Using fake FCM token for testing');
        }
      } catch (e) {
        log('FCM initialization failed: $e');
      }
    }
  }

  /// Update FCM token if user is logged in and token is available
  static Future<bool> updateTokenIfAvailable() async {
    try {
      if (!appStore.isLoggedIn) {
        log('User not logged in, skipping FCM token update');
        return false;
      }

      String? token = await FCMService.getCurrentToken();
      if (token == null || token.isEmpty) {
        log('No FCM token available');
        return false;
      }

      await updateFcmToken(fcmToken: token);
      await userStore.setFcmToken(token);
      
      if (!FCMService.isAvailable()) {
        log('Fake FCM token updated successfully (for testing)');
      } else {
        log('FCM token updated successfully');
      }
      return true;
    } catch (e) {
      log('Error updating FCM token: $e');
      return false;
    }
  }

  /// Check if FCM token is set and valid
  static bool isTokenSet() {
    return userStore.fcmToken.isNotEmpty;
  }

  /// Get stored FCM token
  static String getStoredToken() {
    return userStore.fcmToken;
  }

  /// Clear FCM token (useful for logout)
  static Future<void> clearToken() async {
    await userStore.setFcmToken('');
  }

  /// Refresh FCM token and update on server
  static Future<bool> refreshAndUpdateToken() async {
    try {
      // Force refresh by reinitializing FCM
      await FCMService.initializeFCM();
      
      // Update token on server
      return await updateTokenIfAvailable();
    } catch (e) {
      log('Error refreshing FCM token: $e');
      return false;
    }
  }

  /// Check if FCM is properly configured
  static Future<bool> isFCMConfigured() async {
    try {
      String? token = await FCMService.getCurrentToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      log('FCM not properly configured: $e');
      return false;
    }
  }

  /// Get FCM token status for debugging
  static Future<Map<String, dynamic>> getTokenStatus() async {
    try {
      String? currentToken = await FCMService.getCurrentToken();
      String storedToken = userStore.fcmToken;
      
      return {
        'isLoggedIn': appStore.isLoggedIn,
        'hasCurrentToken': currentToken != null && currentToken.isNotEmpty,
        'hasStoredToken': storedToken.isNotEmpty,
        'tokensMatch': currentToken == storedToken,
        'currentTokenPreview': currentToken?.substring(0, 20) ?? 'null',
        'storedTokenPreview': storedToken.isNotEmpty ? storedToken.substring(0, 20) : 'empty',
      };
    } catch (e) {
      return {
        'error': e.toString(),
      };
    }
  }

  /// Debug function to force generate REAL token and send to server
  static Future<void> debugForceRealToken() async {
    log('🔧 DEBUG: Force generating REAL FCM token...');
    
    if (!appStore.isLoggedIn) {
      log('❌ User not logged in!');
      return;
    }
    
    try {
      await FCMService.forceRefreshAndSendRealToken();
      log('✅ Debug real token generation completed!');
      
      // Print current status
      log('📱 Current UserStore FCM Token: ${userStore.fcmToken.substring(0, 50)}...');
      log('👤 User ID: ${userStore.userId}');
      log('🔑 User logged in: ${appStore.isLoggedIn}');
      
    } catch (e) {
      log('❌ Debug real token generation failed: $e');
    }
  }

  /// Simple test to check if FCM token is stored
  static void checkTokenStatus() {
    log('=== FCM TOKEN STATUS CHECK ===');
    log('User logged in: ${appStore.isLoggedIn}');
    log('User ID: ${userStore.userId}');
    log('FCM Token stored: ${userStore.fcmToken.isNotEmpty}');
    log('FCM Token value: ${userStore.fcmToken}');
    log('FCM Service available: ${FCMService.isAvailable()}');
    log('=== END STATUS CHECK ===');
  }
}