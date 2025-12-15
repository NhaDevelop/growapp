import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';

class FirebaseDebugScreen extends StatefulWidget {
  const FirebaseDebugScreen({super.key});

  @override
  State<FirebaseDebugScreen> createState() => _FirebaseDebugScreenState();
}

class _FirebaseDebugScreenState extends State<FirebaseDebugScreen> {
  String debugOutput = 'Tap "RUN DEBUG" to start Firebase configuration check';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔍 Firebase Debug'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Instructions
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🎯 Firebase Configuration Debug',
                      style: boldTextStyle(size: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This will check if your app is using the correct Firebase project (growtokyo-fd8ae) and generate FCM tokens.',
                      style: secondaryTextStyle(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Debug Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: isLoading ? null : runFirebaseDebug,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('🚀 RUN FIREBASE DEBUG'),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Copy Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: debugOutput.contains('Firebase Project ID') ? copyToClipboard : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                  foregroundColor: Colors.white,
                ),
                child: const Text('📋 COPY RESULTS'),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Output Display
            Expanded(
              child: Card(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Text(
                      debugOutput,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
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

  Future<void> runFirebaseDebug() async {
    setState(() {
      isLoading = true;
      debugOutput = 'Running Firebase debug...\\n';
    });

    try {
      // EXACT DEBUG CODE AS REQUESTED BY BACKEND
      await debugFirebaseConfig();
    } catch (e) {
      setState(() {
        debugOutput += '❌ Error running debug: $e\\n';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> debugFirebaseConfig() async {
    String output = '';
    
    output += '=== 🔍 FIREBASE CONFIGURATION DEBUG ===\\n';
    output += '\\n';
    
    try {
      // Check Firebase project
      String projectId = Firebase.app().options.projectId;
      output += '🔥 Firebase Project ID: $projectId\\n';
      print('🔥 Firebase Project ID: $projectId');

      // Check if it matches expected
      bool isCorrect = projectId == 'growtokyo-fd8ae';
      output += '✅ Using correct project: $isCorrect\\n';
      print('✅ Using correct project: $isCorrect');

      // Get FCM token
      String? token = await FirebaseMessaging.instance.getToken();
      output += '🔑 FCM Token: $token\\n';
      print('🔑 FCM Token: $token');

      if (!isCorrect) {
        output += '❌ ERROR: App is using project $projectId but server expects growtokyo-fd8ae\\n';
        print('❌ ERROR: App is using project $projectId but server expects growtokyo-fd8ae');
      }
      
      // Additional debug info
      output += '\\n=== 📋 ADDITIONAL INFO ===\\n';
      output += '🔢 Project Number: ${Firebase.app().options.messagingSenderId}\\n';
      output += '🔑 API Key: ${Firebase.app().options.apiKey.substring(0, 20)}...\\n';
      output += '📱 App ID: ${Firebase.app().options.appId}\\n';
      output += '🗄️ Storage Bucket: ${Firebase.app().options.storageBucket}\\n';
      
      output += '📏 Token Length: ${token!.length} characters\\n';
      output += '🔍 Token Preview: ${token.substring(0, 50)}...\\n';
      output += '✅ Token Type: ${token.startsWith('fake_fcm_token_') ? 'FAKE (❌)' : 'REAL (✅)'}\\n';
          
      output += '\\n=== 🎯 EXPECTED OUTPUT ===\\n';
      output += '🔥 Firebase Project ID: growtokyo-fd8ae\\n';
      output += '✅ Using correct project: true\\n';
      output += '🔑 FCM Token: dB8snsNfSNmV7G9sEHrPOc...\\n';
      
      output += '\\n=== 📊 RESULT ===\\n';
      if (isCorrect && !token.startsWith('fake_fcm_token_')) {
        output += '🎉 SUCCESS! Configuration is correct!\\n';
        output += '✅ Your backend should accept these tokens.\\n';
      } else {
        output += '❌ ISSUES FOUND:\\n';
        if (!isCorrect) output += '   - Wrong Firebase project\\n';
        if (token.startsWith('fake_fcm_token_') == true) output += '   - Fake token instead of real\\n';
      }
      
    } catch (e) {
      output += '❌ Error in Firebase debug: $e\\n';
      print('❌ Error in Firebase debug: $e');
    }
    
    setState(() {
      debugOutput = output;
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: debugOutput));
    toast('Debug results copied to clipboard!');
  }
}