import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';

class APITestUtils {
  /// Test the FCM token API connection
  static Future<void> testFCMTokenAPI() async {
    log('🧪 TESTING FCM TOKEN API CONNECTION');
    log('📍 Current App Flavor: ${BuildConfig.appFlavor}');
    log('🌐 Domain URL: ${BuildConfig.domainUrl}');
    log('🔗 Base URL: ${BuildConfig.baseUrl}');
    log('🎯 FCM Token Endpoint: ${BuildConfig.baseUrl}update-fcm-token');
    log('👤 User logged in: ${appStore.isLoggedIn}');
    log('🔑 User ID: ${userStore.userId}');
    log('🎫 User token: ${userStore.token.isNotEmpty ? "Present" : "Missing"}');
    
    if (!appStore.isLoggedIn) {
      log('❌ User not logged in - cannot test API');
      return;
    }
    
    try {
      // Test with a simple fake token
      String testToken = 'test_fcm_token_${DateTime.now().millisecondsSinceEpoch}';
      log('📤 Sending test token: $testToken');
      
      await updateFcmToken(fcmToken: testToken);
      log('✅ FCM TOKEN API TEST SUCCESSFUL!');
      
    } catch (e) {
      log('❌ FCM TOKEN API TEST FAILED: $e');
      
      // Additional debugging info
      log('🔍 Error details:');
      log('   - Error type: ${e.runtimeType}');
      log('   - Error message: $e');
      
      if (e.toString().contains('SocketException')) {
        log('🌐 Network connection issue - check if server is running');
        log('   - Expected server: http://192.168.0.137:8000');
        log('   - Check if your local server is running');
        log('   - Check if your device can reach this IP');
      } else if (e.toString().contains('401')) {
        log('🔐 Authentication issue - check user token');
      } else if (e.toString().contains('404')) {
        log('🔍 Endpoint not found - check API route');
      }
    }
  }
  
  /// Test basic network connectivity
  static Future<void> testNetworkConnectivity() async {
    log('🌐 TESTING NETWORK CONNECTIVITY');
    
    try {
      // Test if we can reach the server
      final response = await get(Uri.parse('${BuildConfig.domainUrl}/api/'));
      log('✅ Server reachable - Status: ${response.statusCode}');
    } catch (e) {
      log('❌ Cannot reach server: $e');
      log('🔍 Check:');
      log('   - Is your local server running on http://192.168.0.137:8000?');
      log('   - Is your device on the same network?');
      log('   - Can you ping 192.168.0.137 from your device?');
    }
  }
  
  /// Show current configuration
  static void showCurrentConfig() {
    log('⚙️ CURRENT APP CONFIGURATION');
    log('📱 App Flavor: ${BuildConfig.appFlavor}');
    log('🌐 Domain URL: ${BuildConfig.domainUrl}');
    log('🔗 Base URL: ${BuildConfig.baseUrl}');
    log('👤 User logged in: ${appStore.isLoggedIn}');
    log('🆔 User ID: ${userStore.userId}');
    log('📧 User email: ${userStore.userEmail}');
    log('🎫 Has auth token: ${userStore.token.isNotEmpty}');
    log('📱 FCM token: ${userStore.fcmToken.isNotEmpty ? "Present" : "Missing"}');
    log('🔧 Expected FCM endpoint: ${BuildConfig.baseUrl}update-fcm-token');
  }
}