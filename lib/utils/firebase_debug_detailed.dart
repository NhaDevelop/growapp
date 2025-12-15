import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/build_config.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseDebugDetailed {
  /// Debug Firebase configuration exactly as requested
  static Future<void> debugFirebaseConfig() async {
    log('=== 🔍 DETAILED FIREBASE CONFIGURATION DEBUG ===');
    
    try {
      // Check Firebase project
      String projectId = Firebase.app().options.projectId;
      print('🔥 Firebase Project ID: $projectId');

      // Check if it matches expected
      bool isCorrect = projectId == 'growtokyo-fd8ae';
      print('✅ Using correct project: $isCorrect');

      // Get FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      print('🔑 FCM Token: $token');

      if (!isCorrect) {
        print('❌ ERROR: App is using project $projectId but server expects growtokyo-fd8ae');
      }
      
      // Additional detailed debugging
      await _detailedFirebaseDebug();
      
    } catch (e) {
      print('❌ Error in Firebase debug: $e');
      log('❌ Error in Firebase debug: $e');
    }
  }
  
  /// Comprehensive Firebase configuration debugging
  static Future<void> _detailedFirebaseDebug() async {
    log('');
    log('=== 📱 DETAILED FIREBASE APP CONFIGURATION ===');
    
    try {
      FirebaseApp app = Firebase.app();
      FirebaseOptions options = app.options;
      
      // Print all Firebase configuration details
      log('📱 App Name: ${app.name}');
      log('🆔 Project ID: ${options.projectId}');
      log('🔢 Project Number: ${options.messagingSenderId}');
      log('🔑 API Key: ${options.apiKey.substring(0, 20)}...');
      log('📱 App ID: ${options.appId}');
      log('🗄️ Storage Bucket: ${options.storageBucket}');
      
      // Check expected vs actual
      log('');
      log('=== ✅ EXPECTED VS ACTUAL COMPARISON ===');
      log('Expected Project ID: growtokyo-fd8ae');
      log('Actual Project ID: ${options.projectId}');
      log('Match: ${options.projectId == 'growtokyo-fd8ae' ? '✅ YES' : '❌ NO'}');
      
      if (options.projectId != 'growtokyo-fd8ae') {
        log('');
        log('🚨 CRITICAL ISSUE DETECTED:');
        log('   Your app is using Firebase project: ${options.projectId}');
        log('   But your backend expects: growtokyo-fd8ae');
        log('   This is why FCM tokens are being rejected!');
      }
      
      // Check build configuration
      log('');
      log('=== 🏗️ BUILD CONFIGURATION ===');
      log('App Flavor: ${BuildConfig.appFlavor}');
      log('Base URL: ${BuildConfig.baseUrl}');
      
      // Check FCM token details
      await _debugFCMToken();
      
      // Check package name
      await _debugPackageName();
      
    } catch (e) {
      log('❌ Error in detailed Firebase debug: $e');
    }
  }
  
  /// Debug FCM token generation
  static Future<void> _debugFCMToken() async {
    log('');
    log('=== 🔑 FCM TOKEN DEBUGGING ===');
    
    try {
      // Get FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      
      log('✅ FCM Token Generated: YES');
      log('📏 Token Length: ${token!.length} characters');
      log('🔍 Token Preview: ${token.substring(0, 50)}...');
      log('🔗 Token Type: ${token.startsWith('fake_fcm_token_') ? 'FAKE (❌)' : 'REAL (✅)'}');
      
      // Check if token is valid format
      bool isValidFormat = token.length > 100 && !token.startsWith('fake_fcm_token_');
      log('✅ Valid Token Format: ${isValidFormat ? 'YES' : 'NO'}');
      
      // Store token for comparison
      String storedToken = userStore.fcmToken;
      log('💾 Stored Token Matches: ${storedToken == token ? 'YES' : 'NO'}');
      
          
    } catch (e) {
      log('❌ Error getting FCM token: $e');
    }
  }
  
  /// Debug package name configuration
  static Future<void> _debugPackageName() async {
    log('');
    log('=== 📦 PACKAGE NAME DEBUGGING ===');
    
    try {
      // Expected package names
      Map<String, String> expectedPackages = {
        'Production': 'com.growtokyo',
        'Staging': 'com.growtokyo.staging',
      };
      
      log('Expected Package Names:');
      expectedPackages.forEach((env, pkg) {
        log('   $env: $pkg');
      });
      
      // Current build flavor
      log('Current Build Flavor: ${BuildConfig.appFlavor}');
      
      String expectedPkg = BuildConfig.appFlavor == AppFlavor.prod 
          ? 'com.growtokyo' 
          : 'com.growtokyo.staging';
      log('Expected Package for Current Flavor: $expectedPkg');
      
    } catch (e) {
      log('❌ Error in package name debug: $e');
    }
  }
  
  /// Complete configuration verification
  static Future<Map<String, dynamic>> getCompleteConfigurationReport() async {
    log('=== 📋 GENERATING COMPLETE CONFIGURATION REPORT ===');
    
    Map<String, dynamic> report = {};
    
    try {
      // Firebase configuration
      FirebaseApp app = Firebase.app();
      FirebaseOptions options = app.options;
      
      report['firebase'] = {
        'projectId': options.projectId,
        'expectedProjectId': 'growtokyo-fd8ae',
        'isCorrectProject': options.projectId == 'growtokyo-fd8ae',
        'projectNumber': options.messagingSenderId,
        'apiKey': '${options.apiKey.substring(0, 20)}...',
        'appId': options.appId,
        'storageBucket': options.storageBucket,
      };
      
      // FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      report['fcmToken'] = {
        'hasToken': token != null,
        'tokenLength': token!.length,
        'tokenPreview': token.substring(0, 50),
        'isFakeToken': token.startsWith('fake_fcm_token_'),
        'isValidFormat': token.length > 100 && !token.startsWith('fake_fcm_token_'),
      };
      
      // Build configuration
      report['buildConfig'] = {
        'appFlavor': BuildConfig.appFlavor.toString(),
        'baseUrl': BuildConfig.baseUrl,
        'isProduction': BuildConfig.appFlavor == AppFlavor.prod,
      };
      
      // User state
      report['userState'] = {
        'isLoggedIn': appStore.isLoggedIn,
        'userId': userStore.userId,
        'storedFcmToken': userStore.fcmToken,
        'storedTokenLength': userStore.fcmToken.length,
      };
      
      // Overall status
      bool isConfigurationCorrect = report['firebase']['isCorrectProject'] && 
                                   report['fcmToken']['isValidFormat'];
      
      report['overallStatus'] = {
        'isConfigurationCorrect': isConfigurationCorrect,
        'readyForProduction': isConfigurationCorrect && report['userState']['isLoggedIn'],
      };
      
      // Print summary
      log('');
      log('=== 📊 CONFIGURATION SUMMARY ===');
      log('Firebase Project: ${report['firebase']['projectId']} ${report['firebase']['isCorrectProject'] ? '✅' : '❌'}');
      log('FCM Token: ${report['fcmToken']['hasToken'] ? '✅' : '❌'} (${report['fcmToken']['tokenLength']} chars)');
      log('Build Config: ${report['buildConfig']['appFlavor']}');
      log('Overall Status: ${report['overallStatus']['isConfigurationCorrect'] ? '✅ READY' : '❌ NEEDS FIX'}');
      
      return report;
      
    } catch (e) {
      log('❌ Error generating configuration report: $e');
      report['error'] = e.toString();
      return report;
    }
  }
  
  /// Print configuration fix instructions
  static void printFixInstructions(Map<String, dynamic> report) {
    log('');
    log('=== 🛠️ CONFIGURATION FIX INSTRUCTIONS ===');
    
    if (report['firebase']?['isCorrectProject'] != true) {
      log('❌ ISSUE: Wrong Firebase Project');
      log('🔧 SOLUTION:');
      log('   1. Check android/app/google-services.json');
      log('   2. Verify project_id is "growtokyo-fd8ae"');
      log('   3. Download correct config from Firebase Console');
      log('   4. Replace the file and rebuild app');
    }
    
    if (report['fcmToken']?['isValidFormat'] != true) {
      log('❌ ISSUE: Invalid FCM Token');
      log('🔧 SOLUTION:');
      log('   1. Clear app data');
      log('   2. Restart app');
      log('   3. Login again');
      log('   4. Use FCM verification tools');
    }
    
    if (report['overallStatus']?['isConfigurationCorrect'] == true) {
      log('✅ CONFIGURATION IS CORRECT!');
      log('🎉 Your app should work with the backend now!');
    }
  }
}