import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/services/fcm_service.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseProjectChecker {
  /// Check which Firebase project the app is currently using
  static Future<Map<String, dynamic>> checkCurrentFirebaseProject() async {
    log('=== FIREBASE PROJECT VERIFICATION ===');
    
    try {
      // Get Firebase app instance
      FirebaseApp app = Firebase.app();
      
      Map<String, dynamic> projectInfo = {
        'appName': app.name,
        'projectId': app.options.projectId,
        'apiKey': app.options.apiKey,
        'appId': app.options.appId,
        'messagingSenderId': app.options.messagingSenderId,
        'storageBucket': app.options.storageBucket,
      };
      
      log('📱 Firebase App Name: ${projectInfo['appName']}');
      log('🆔 Project ID: ${projectInfo['projectId']}');
      log('🔑 API Key: ${projectInfo['apiKey']?.substring(0, 20)}...');
      log('📱 App ID: ${projectInfo['appId']}');
      log('📨 Messaging Sender ID: ${projectInfo['messagingSenderId']}');
      log('🗄️ Storage Bucket: ${projectInfo['storageBucket']}');
      
      // Check if it's the expected project
      bool isCorrectProject = projectInfo['projectId'] == 'growtokyo-fd8ae';
      log('✅ Using correct project (growtokyo-fd8ae): $isCorrectProject');
      
      if (!isCorrectProject) {
        log('❌ WRONG PROJECT! Expected: growtokyo-fd8ae, Got: ${projectInfo['projectId']}');
      }
      
      projectInfo['isCorrectProject'] = isCorrectProject;
      
      return projectInfo;
    } catch (e) {
      log('❌ Error checking Firebase project: $e');
      return {'error': e.toString()};
    }
  }
  
  /// Generate a fresh FCM token and verify it's from the correct project
  static Future<Map<String, dynamic>> generateAndVerifyFCMToken() async {
    log('=== GENERATING FRESH FCM TOKEN ===');
    
    try {
      // First check the project
      Map<String, dynamic> projectInfo = await checkCurrentFirebaseProject();
      
      if (projectInfo.containsKey('error')) {
        return projectInfo;
      }
      
      // Clear any existing tokens
      await FCMService.clearFakeTokens();
      
      // Initialize FCM
      await FCMService.initializeFCM();
      
      // Get fresh token
      String? token = await FCMService.getCurrentToken();
      
      Map<String, dynamic> result = {
        'projectId': projectInfo['projectId'],
        'isCorrectProject': projectInfo['isCorrectProject'],
        'hasToken': token != null && token.isNotEmpty,
        'tokenLength': token?.length ?? 0,
        'tokenPreview': token != null ? token.substring(0, 50) : 'null',
        'isFakeToken': token?.startsWith('fake_fcm_token_') ?? false,
        'isRealToken': token != null && !token.startsWith('fake_fcm_token_') && token.length > 100,
      };
      
      log('🔥 FCM Token Generated:');
      log('   Project ID: ${result['projectId']}');
      log('   Correct Project: ${result['isCorrectProject']}');
      log('   Has Token: ${result['hasToken']}');
      log('   Token Length: ${result['tokenLength']}');
      log('   Is Real Token: ${result['isRealToken']}');
      log('   Token Preview: ${result['tokenPreview']}...');
      
      if (result['isCorrectProject'] && result['isRealToken']) {
        log('✅ SUCCESS! Real FCM token from correct project generated!');
        
        // Save the token
        if (token != null) {
          await userStore.setFcmToken(token);
          
          // Send to server if logged in
          if (appStore.isLoggedIn) {
            try {
              await updateFcmToken(fcmToken: token);
              log('📤 Token sent to server successfully');
              result['sentToServer'] = true;
            } catch (e) {
              log('❌ Failed to send token to server: $e');
              result['sentToServer'] = false;
              result['serverError'] = e.toString();
            }
          }
        }
      } else {
        log('❌ ISSUE DETECTED:');
        if (!result['isCorrectProject']) {
          log('   - Wrong Firebase project');
        }
        if (!result['isRealToken']) {
          log('   - Not a real FCM token');
        }
      }
      
      return result;
    } catch (e) {
      log('❌ Error generating FCM token: $e');
      return {'error': e.toString()};
    }
  }
  
  /// Complete verification and fix process
  static Future<bool> verifyAndFixFirebaseConfiguration() async {
    log('=== COMPLETE FIREBASE VERIFICATION & FIX ===');
    
    try {
      // Step 1: Check current project
      Map<String, dynamic> projectCheck = await checkCurrentFirebaseProject();
      
      if (projectCheck.containsKey('error')) {
        log('❌ Firebase not properly initialized');
        return false;
      }
      
      // Step 2: Verify project ID
      if (!projectCheck['isCorrectProject']) {
        log('❌ CRITICAL: App is using wrong Firebase project!');
        log('   Expected: growtokyo-fd8ae');
        log('   Current: ${projectCheck['projectId']}');
        log('🔧 Solution: Check google-services.json file');
        return false;
      }
      
      // Step 3: Generate fresh FCM token
      Map<String, dynamic> tokenResult = await generateAndVerifyFCMToken();
      
      if (tokenResult.containsKey('error')) {
        log('❌ Failed to generate FCM token');
        return false;
      }
      
      // Step 4: Verify everything is working
      bool success = tokenResult['isCorrectProject'] && 
                    tokenResult['isRealToken'] && 
                    (tokenResult['sentToServer'] ?? false);
      
      if (success) {
        log('🎉 COMPLETE SUCCESS!');
        log('✅ Correct Firebase project: growtokyo-fd8ae');
        log('✅ Real FCM token generated');
        log('✅ Token sent to server');
        log('✅ Your backend should now receive valid tokens!');
      } else {
        log('❌ VERIFICATION FAILED - Check the issues above');
      }
      
      return success;
    } catch (e) {
      log('❌ Error in verification process: $e');
      return false;
    }
  }
}