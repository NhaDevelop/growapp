import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/services/fcm_service.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:nb_utils/nb_utils.dart';

class FCMDebugUtils {
  /// Check current FCM token status and identify if it's fake or real
  static void checkTokenStatus() {
    log('=== FCM TOKEN DEBUG STATUS ===');
    log('User logged in: ${appStore.isLoggedIn}');
    log('User ID: ${userStore.userId}');
    
    String currentToken = userStore.fcmToken;
    if (currentToken.isEmpty) {
      log('❌ No FCM token stored');
    } else {
      bool isFakeToken = currentToken.startsWith('fake_fcm_token_');
      log('Token exists: YES');
      log('Token type: ${isFakeToken ? "❌ FAKE TOKEN (PROBLEM!)" : "✅ REAL TOKEN (GOOD!)"}');
      log('Token length: ${currentToken.length} characters');
      
      if (isFakeToken) {
        log('🚨 FAKE TOKEN DETECTED: $currentToken');
        log('🔧 This needs to be replaced with a real Firebase token');
      } else {
        log('🔥 Real token preview: ${currentToken.substring(0, 50)}...');
        log('✅ Token appears to be a valid Firebase token');
      }
    }
    
    log('FCM Service available: ${FCMService.isAvailable()}');
    log('=== END DEBUG STATUS ===');
  }
  
  /// Force clear all fake tokens and generate real ones
  static Future<void> clearFakeTokensAndGenerateReal() async {
    log('=== CLEARING FAKE TOKENS AND GENERATING REAL ONES ===');
    
    if (!appStore.isLoggedIn) {
      log('❌ User not logged in - cannot proceed');
      return;
    }
    
    try {
      // Step 1: Clear fake tokens
      String currentToken = userStore.fcmToken;
      if (currentToken.startsWith('fake_fcm_token_')) {
        log('🧹 Clearing fake token: $currentToken');
        await userStore.setFcmToken('');
        log('✅ Fake token cleared from storage');
      }
      
      // Step 2: Clear from FCM service
      await FCMService.clearFakeTokens();
      
      // Step 3: Force initialize FCM
      log('🚀 Initializing Firebase Cloud Messaging...');
      await FCMService.initializeFCM();
      
      // Step 4: Get real token
      String? realToken = await FCMService.getCurrentToken();
      
      if (realToken != null && realToken.isNotEmpty && !realToken.startsWith('fake_fcm_token_')) {
        log('🔥 SUCCESS! Real FCM token generated: ${realToken.substring(0, 50)}...');
        
        // Step 5: Save real token
        await userStore.setFcmToken(realToken);
        log('💾 Real token saved to storage');
        
        // Step 6: Send to server
        try {
          await updateFcmToken(fcmToken: realToken);
          log('📤 Real token sent to server successfully');
          log('✅ COMPLETE! Your app now uses real FCM tokens');
        } catch (e) {
          log('❌ Failed to send real token to server: $e');
        }
      } else {
        log('❌ Failed to generate real FCM token');
        log('🔧 Possible issues:');
        log('   - Firebase not properly configured');
        log('   - Missing permissions');
        log('   - Network connectivity issues');
        log('   - Firebase project configuration');
      }
    } catch (e) {
      log('❌ Error in clearing fake tokens: $e');
    }
    
    log('=== CLEAR FAKE TOKENS COMPLETE ===');
  }
  
  /// Verify that the current token is real and valid
  static bool isCurrentTokenReal() {
    String currentToken = userStore.fcmToken;
    return currentToken.isNotEmpty && 
           !currentToken.startsWith('fake_fcm_token_') &&
           currentToken.length >= 150;
  }
  
  /// Get detailed token information
  static Map<String, dynamic> getTokenInfo() {
    String currentToken = userStore.fcmToken;
    
    return {
      'hasToken': currentToken.isNotEmpty,
      'isFakeToken': currentToken.startsWith('fake_fcm_token_'),
      'isRealToken': currentToken.isNotEmpty && !currentToken.startsWith('fake_fcm_token_'),
      'tokenLength': currentToken.length,
      'tokenPreview': currentToken.isNotEmpty ? currentToken.substring(0, 50) : 'none',
      'isValidLength': currentToken.length >= 150,
      'fcmServiceAvailable': FCMService.isAvailable(),
      'userLoggedIn': appStore.isLoggedIn,
      'userId': userStore.userId,
    };
  }
}