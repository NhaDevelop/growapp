import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

/// EXACT DEBUG CODE AS REQUESTED BY BACKEND TEAM
/// Add this to your main.dart or call it from a button
void debugFirebaseConfig() async {
  print('=== 🔍 FIREBASE CONFIGURATION DEBUG ===');
  
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
    
    // Additional debugging information
    print('');
    print('=== 📋 ADDITIONAL DEBUG INFO ===');
    print('🔢 Project Number: ${Firebase.app().options.messagingSenderId}');
    print('🔑 API Key: ${Firebase.app().options.apiKey.substring(0, 20)}...');
    print('📱 App ID: ${Firebase.app().options.appId}');
    print('🗄️ Storage Bucket: ${Firebase.app().options.storageBucket}');
    
    if (token != null) {
      print('📏 Token Length: ${token.length} characters');
      print('🔍 Token Preview: ${token.substring(0, 50)}...');
      print('✅ Token Type: ${token.startsWith('fake_fcm_token_') ? 'FAKE (❌)' : 'REAL (✅)'}');
    }
    
    print('');
    print('=== 🎯 WHAT SHOULD HAPPEN ===');
    print('Expected Output:');
    print('🔥 Firebase Project ID: growtokyo-fd8ae');
    print('✅ Using correct project: true');
    print('🔑 FCM Token: dB8snsNfSNmV7G9sEHrPOc...');
    
  } catch (e) {
    print('❌ Error in Firebase debug: $e');
  }
}

/// Widget to test Firebase configuration
class FirebaseDebugWidget extends StatefulWidget {
  @override
  _FirebaseDebugWidgetState createState() => _FirebaseDebugWidgetState();
}

class _FirebaseDebugWidgetState extends State<FirebaseDebugWidget> {
  String debugOutput = 'Tap button to run debug';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Debug Test'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  debugOutput = 'Running debug...';
                });
                
                // Capture debug output
                await debugFirebaseConfig();
                
                // Get the actual values
                try {
                  String projectId = Firebase.app().options.projectId;
                  bool isCorrect = projectId == 'growtokyo-fd8ae';
                  String? token = await FirebaseMessaging.instance.getToken();
                  
                  setState(() {
                    debugOutput = '''
🔥 Firebase Project ID: $projectId
✅ Using correct project: $isCorrect
🔑 FCM Token: ${token ?? 'null'}

${!isCorrect ? '❌ ERROR: App is using project $projectId but server expects growtokyo-fd8ae' : '✅ Configuration is correct!'}
                    ''';
                  });
                } catch (e) {
                  setState(() {
                    debugOutput = 'Error: $e';
                  });
                }
              },
              child: Text('🔍 DEBUG FIREBASE CONFIG'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    debugOutput,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}