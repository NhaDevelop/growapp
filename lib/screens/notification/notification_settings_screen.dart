import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/models/notification_user_response.dart';
import 'package:grow_tokyo_app/network/rest_apis.dart';
import 'package:grow_tokyo_app/services/fcm_service.dart';
import 'package:grow_tokyo_app/utils/fcm_startup_utils.dart';
import 'package:grow_tokyo_app/utils/fcm_debug_utils.dart';
import 'package:grow_tokyo_app/utils/firebase_project_checker.dart';
import 'package:grow_tokyo_app/utils/firebase_debug_detailed.dart';
import 'package:grow_tokyo_app/utils/api_test_utils.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool isLoading = false;
  NotificationUserResponse? userNotificationData;
  String? currentFcmToken;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    await loadUserNotificationData();
    await getCurrentFcmToken();
  }

  Future<void> loadUserNotificationData() async {
    setState(() {
      isLoading = true;
    });

    try {
      userNotificationData = await getNotificationUserGetPoint();
      setState(() {});
    } catch (e) {
      toast(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getCurrentFcmToken() async {
    try {
      currentFcmToken = await FCMService.getCurrentToken();
      if (!FCMService.isAvailable() && currentFcmToken != null) {
        currentFcmToken = '$currentFcmToken (FALLBACK TOKEN)';
      } else if (FCMService.isAvailable() && currentFcmToken != null) {
        currentFcmToken = '$currentFcmToken (REAL FCM TOKEN)';
      }
      setState(() {});
    } catch (e) {
      log('Error getting FCM token: $e');
      currentFcmToken = 'Error: ${e.toString()}';
      setState(() {});
    }
  }

  Future<void> updateFcmTokenAction() async {
    if (currentFcmToken == null || currentFcmToken!.isEmpty) {
      toast('No FCM token available');
      return;
    }
    
    // Extract actual token (remove fake token suffix if present)
    String tokenToSend = currentFcmToken!
        .replaceAll(' (FALLBACK TOKEN)', '')
        .replaceAll(' (REAL FCM TOKEN)', '');

    setState(() {
      isLoading = true;
    });

    try {
      await updateFcmToken(fcmToken: tokenToSend);
      await userStore.setFcmToken(tokenToSend);
      if (!FCMService.isAvailable()) {
        toast('Fallback FCM token updated successfully');
      } else {
        toast('Real FCM token updated successfully');
      }
      await loadUserNotificationData(); // Refresh data
    } catch (e) {
      toast('Error updating FCM token: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshFcmToken() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FCMService.initializeFCM();
      await getCurrentFcmToken();
      if (!FCMService.isAvailable()) {
        toast('Fallback FCM token refreshed');
      } else {
        toast('Real FCM token refreshed');
      }
    } catch (e) {
      toast('Error refreshing FCM token: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> testFakeTokenGeneration() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FCMService.testRealTokenGeneration();
      await getCurrentFcmToken();
      toast('Real FCM token test completed - check logs');
    } catch (e) {
      toast('Error testing real token: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> forceGenerateAndSendToken() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FCMService.forceRefreshAndSendRealToken();
      await getCurrentFcmToken();
      await loadUserNotificationData(); // Refresh user data
      toast('FORCED real token refresh and server update - check logs!');
    } catch (e) {
      toast('Error in forced real token refresh: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> useStartupUtils() async {
    setState(() {
      isLoading = true;
    });

    try {
      // First check current status
      FCMStartupUtils.checkTokenStatus();
      
      // Force generate using startup utils
      await FCMStartupUtils.forceGenerateRealToken();
      
      // Refresh UI
      await getCurrentFcmToken();
      await loadUserNotificationData();
      
      toast('Startup Utils fake token generation completed - check logs!');
    } catch (e) {
      toast('Error with startup utils: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> testAPIConnection() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Show current configuration
      APITestUtils.showCurrentConfig();
      
      // Test network connectivity
      await APITestUtils.testNetworkConnectivity();
      
      // Test FCM token API
      await APITestUtils.testFCMTokenAPI();
      
      toast('API connection test completed - check logs for details!');
    } catch (e) {
      toast('API test error: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> clearFakeTokensAndGenerateReal() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Check current token status
      FCMDebugUtils.checkTokenStatus();
      
      // Clear fake tokens and generate real ones
      await FCMDebugUtils.clearFakeTokensAndGenerateReal();
      
      // Refresh UI
      await getCurrentFcmToken();
      await loadUserNotificationData();
      
      // Check final status
      if (FCMDebugUtils.isCurrentTokenReal()) {
        toast('✅ SUCCESS! Real FCM token generated and stored!');
      } else {
        toast('❌ Failed to generate real FCM token - check logs');
      }
    } catch (e) {
      toast('Error clearing fake tokens: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> verifyFirebaseProject() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Complete Firebase verification and fix
      bool success = await FirebaseProjectChecker.verifyAndFixFirebaseConfiguration();
      
      // Refresh UI
      await getCurrentFcmToken();
      await loadUserNotificationData();
      
      if (success) {
        toast('✅ SUCCESS! Firebase project verified and FCM token generated!');
      } else {
        toast('❌ Firebase verification failed - check logs for details');
      }
    } catch (e) {
      toast('Error verifying Firebase project: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> runDetailedFirebaseDebug() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Run the exact debug code as requested
      await FirebaseDebugDetailed.debugFirebaseConfig();
      
      // Generate complete configuration report
      Map<String, dynamic> report = await FirebaseDebugDetailed.getCompleteConfigurationReport();
      
      // Print fix instructions
      FirebaseDebugDetailed.printFixInstructions(report);
      
      // Refresh UI
      await getCurrentFcmToken();
      await loadUserNotificationData();
      
      // Show result based on configuration
      bool isCorrect = report['firebase']?['isCorrectProject'] ?? false;
      bool hasValidToken = report['fcmToken']?['isValidFormat'] ?? false;
      
      if (isCorrect && hasValidToken) {
        toast('✅ SUCCESS! Configuration is correct - check logs for details');
      } else {
        List issues = [];
        if (!isCorrect) issues.add('Wrong Firebase project');
        if (!hasValidToken) issues.add('Invalid FCM token');
        toast('❌ Issues found: ${issues.join(', ')} - check logs');
      }
    } catch (e) {
      toast('Error in detailed Firebase debug: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> testLocalNotification() async {
    setState(() {
      isLoading = true;
    });

    try {
      await FCMService.testLocalNotification();
      toast('✅ Test notification sent to notification bar!');
    } catch (e) {
      toast('Error testing local notification: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Information',
                            style: boldTextStyle(size: 18),
                          ),
                          const SizedBox(height: 16),
                          if (userNotificationData != null) ...[
                            _buildInfoRow('ID', userNotificationData!.id?.toString() ?? 'N/A'),
                            _buildInfoRow('Name', userNotificationData!.name ?? 'N/A'),
                            _buildInfoRow('Points', userNotificationData!.points?.toString() ?? '0'),
                            _buildInfoRow('FCM Token Status', 
                                userNotificationData!.fcmToken?.isNotEmpty == true ? 'Active' : 'Not Set'),
                          ] else ...[
                            const Text('No user data available'),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // FCM Token Information Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FCM Token Information',
                            style: boldTextStyle(size: 18),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Local FCM Token', userStore.fcmToken.isNotEmpty ? 'Set' : 'Not Set'),
                          _buildInfoRow('Current Device Token', currentFcmToken != null ? 'Available' : 'Not Available'),
                          if (currentFcmToken != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Token Preview:',
                              style: boldTextStyle(size: 14),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                currentFcmToken!.length > 50 
                                    ? '${currentFcmToken!.substring(0, 50)}...'
                                    : currentFcmToken!,
                                style: secondaryTextStyle(size: 12),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: updateFcmTokenAction,
                          child: const Text('Update FCM Token'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: refreshFcmToken,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Text('Refresh FCM Token'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loadUserNotificationData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Reload User Data'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: testFakeTokenGeneration,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                          ),
                          child: const Text('Test Fake Token Generation'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: forceGenerateAndSendToken,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('FORCE Generate & Send Token'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: useStartupUtils,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Use Startup Utils (RECOMMENDED)'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: runDetailedFirebaseDebug,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                          ),
                          child: const Text('🔍 DEBUG FIREBASE CONFIG (DETAILED)'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: verifyFirebaseProject,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                          ),
                          child: const Text('🔥 VERIFY FIREBASE PROJECT (growtokyo-fd8ae)'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: clearFakeTokensAndGenerateReal,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[700],
                          ),
                          child: const Text('🧹 CLEAR FAKE TOKENS & GENERATE REAL'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: testLocalNotification,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple[700],
                          ),
                          child: const Text('🔔 TEST NOTIFICATION BAR'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: testAPIConnection,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: const Text('TEST API CONNECTION'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: boldTextStyle(size: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: primaryTextStyle(size: 14),
            ),
          ),
        ],
      ),
    );
  }
}