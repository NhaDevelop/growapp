import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/services/fcm_service.dart';
import 'package:nb_utils/nb_utils.dart';

class FCMStartupUtils {
  /// Initialize REAL FCM for users who are already logged in when app starts
  static Future<void> initializeForLoggedInUser() async {
    if (!appStore.isLoggedIn) {
      log('User not logged in - skipping FCM initialization');
      return;
    }

    log('🚀 Initializing REAL FCM for already logged-in user on app startup');
    
    try {
      // First, clear any existing fake tokens
      await FCMService.clearFakeTokens();
      
      // Initialize real FCM service
      await FCMService.initializeFCM();
      
      // Get real FCM token
      String? realToken = await FCMService.getCurrentToken();
      
      if (realToken != null && realToken.isNotEmpty && !realToken.startsWith('fake_fcm_token_')) {
        log('🔥 Real FCM token obtained: ${realToken.substring(0, 50)}...');
        
        // Save real token to UserStore
        await userStore.setFcmToken(realToken);
        log('💾 Real FCM token saved to UserStore');
        
        // Send real token to server
        try {
          await updateFcmToken(fcmToken: realToken);
          log('📤 Real FCM token sent to server successfully');
        } catch (e) {
          log('❌ Failed to send real FCM token to server: $e');
        }
      } else {
        log('⚠️ Failed to get real FCM token');
        
        // Check if we have a stored REAL token (not fake)
        String storedToken = userStore.fcmToken;
        if (storedToken.isNotEmpty && !storedToken.startsWith('fake_fcm_token_')) {
          log('✅ Using existing real FCM token from storage');
          
          // Try to update existing real token on server
          try {
            await updateFcmToken(fcmToken: storedToken);
            log('📤 Existing real FCM token sent to server successfully');
          } catch (e) {
            log('❌ Failed to send existing real token to server: $e');
          }
        } else {
          log('❌ No valid real FCM token available');
          log('🔧 Please check Firebase configuration and permissions');
          // Clear any fake tokens
          if (storedToken.startsWith('fake_fcm_token_')) {
            await userStore.setFcmToken('');
            log('🧹 Cleared fake token from storage');
          }
        }
      }
    } catch (e) {
      log('❌ Error in real FCM startup initialization: $e');
    }
  }

  /// Force generate REAL FCM token
  static Future<void> forceGenerateRealToken() async {
    if (!appStore.isLoggedIn) {
      log('User not logged in - cannot generate token');
      return;
    }

    log('🔧 Force generating REAL FCM token...');
    
    try {
      // First, clear any existing fake tokens
      await FCMService.clearFakeTokens();
      
      // Re-initialize FCM service to get fresh token
      await FCMService.initializeFCM();
      
      // Get fresh real FCM token
      String? realToken = await FCMService.getCurrentToken();
      
      if (realToken != null && realToken.isNotEmpty && !realToken.startsWith('fake_fcm_token_')) {
        log('🔥 Fresh real FCM token generated: ${realToken.substring(0, 50)}...');
        
        // Save to UserStore
        await userStore.setFcmToken(realToken);
        log('💾 Real FCM token saved to UserStore');
        
        // Send to server
        try {
          await updateFcmToken(fcmToken: realToken);
          log('📤 Real FCM token sent to server successfully');
        } catch (e) {
          log('❌ Failed to send real FCM token to server: $e');
        }
      } else {
        log('❌ Failed to generate real FCM token');
        log('🔧 Please check Firebase configuration and permissions');
      }
    } catch (e) {
      log('❌ Error generating real FCM token: $e');
    }
  }

  /// Check current FCM token status
  static void checkTokenStatus() {
    log('=== FCM TOKEN STATUS ===');
    log('User logged in: ${appStore.isLoggedIn}');
    log('User ID: ${userStore.userId}');
    log('FCM Token stored: ${userStore.fcmToken.isNotEmpty}');
    log('FCM Token: ${userStore.fcmToken}');
    log('========================');
  }
}