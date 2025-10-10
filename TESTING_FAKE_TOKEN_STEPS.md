# Step-by-Step Testing Guide for Fake FCM Tokens

## 🎯 **Quick Test Methods**

### **Method 1: Test After Login (Automatic)**
1. **Login to your app** with any user account
2. **Check Flutter logs** immediately after login for these messages:
```
I/flutter: Firebase Messaging not available - using fake token for testing
I/flutter: Generated fake token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: Updating FCM token to server after login: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: ✅ Fake token successfully sent to server!
```

### **Method 2: Manual Debug Function**
Add this code anywhere in your app (like in a button press or after login):

```dart
import 'package:grow_tokyo_app/utils/fcm_utils.dart';

// Check current token status
FCMUtils.checkTokenStatus();

// Force generate and send fake token
await FCMUtils.debugForceFakeToken();
```

### **Method 3: Use the Test Screen**
1. Navigate to `NotificationSettingsScreen`
2. Click the **red "FORCE Generate & Send Token"** button
3. Check logs for detailed output
4. The screen will show the fake token with "(FAKE TOKEN FOR TESTING)" label

## 🔍 **What to Look For**

### **In Flutter Logs:**
```
🔧 DEBUG: Force generating fake FCM token...
=== FORCE GENERATING FAKE TOKEN ===
Generated fake token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
Saved to UserStore: fake_fcm_token_4107_1703123456789_grow_tokyo_app
✅ Fake token successfully sent to server!
=== FORCE GENERATION COMPLETE ===
```

### **In Your Backend Logs:**
Your `/api/update-fcm-token` endpoint should receive:
```json
{
  "fcm_token": "fake_fcm_token_4107_1703123456789_grow_tokyo_app"
}
```

### **In UserStore:**
```dart
print('FCM Token: ${userStore.fcmToken}');
// Should output: fake_fcm_token_4107_1703123456789_grow_tokyo_app
```

## 🧪 **Quick Debug Code**

Add this to any screen to test immediately:

```dart
// Add this button to any screen for quick testing
ElevatedButton(
  onPressed: () async {
    // Check current status
    print('=== BEFORE TEST ===');
    print('User logged in: ${appStore.isLoggedIn}');
    print('User ID: ${userStore.userId}');
    print('Current FCM token: ${userStore.fcmToken}');
    
    // Force generate fake token
    if (appStore.isLoggedIn) {
      await FCMUtils.debugForceFakeToken();
      
      print('=== AFTER TEST ===');
      print('New FCM token: ${userStore.fcmToken}');
    } else {
      print('❌ User not logged in!');
    }
  },
  child: Text('Test Fake FCM Token'),
)
```

## 🔧 **Troubleshooting**

### **If No Token is Generated:**
1. **Check if user is logged in:**
```dart
print('User logged in: ${appStore.isLoggedIn}');
print('User ID: ${userStore.userId}');
```

2. **Manually trigger token generation:**
```dart
await FCMService.forceGenerateAndSendFakeToken();
```

3. **Check UserStore directly:**
```dart
print('UserStore FCM Token: ${userStore.fcmToken}');
```

### **If Token Not Sent to Server:**
1. **Check network connectivity**
2. **Verify API endpoint is working:**
```dart
try {
  await updateFcmToken(fcmToken: 'test_token');
  print('✅ API endpoint working');
} catch (e) {
  print('❌ API endpoint error: $e');
}
```

3. **Check authentication:**
```dart
print('User token: ${userStore.token}');
print('Is logged in: ${appStore.isLoggedIn}');
```

## 📱 **Expected Fake Token Format**
```
fake_fcm_token_{user_id}_{timestamp}_grow_tokyo_app

Example:
fake_fcm_token_4107_1703123456789_grow_tokyo_app
```

## ✅ **Success Checklist**

- [ ] User can login successfully
- [ ] Fake token is generated (check logs)
- [ ] Token is stored in UserStore (`userStore.fcmToken` not empty)
- [ ] Token is sent to backend (check server logs)
- [ ] `/api/update-fcm-token` receives the fake token
- [ ] Test screen shows fake token with label
- [ ] Manual debug functions work

## 🎯 **Quick Verification**

Run this code after login to verify everything is working:

```dart
// Quick verification function
void verifyFCMIntegration() {
  print('=== FCM INTEGRATION VERIFICATION ===');
  print('✅ User logged in: ${appStore.isLoggedIn}');
  print('✅ User ID: ${userStore.userId}');
  print('✅ FCM token stored: ${userStore.fcmToken.isNotEmpty}');
  print('✅ FCM token: ${userStore.fcmToken}');
  
  if (userStore.fcmToken.contains('fake_fcm_token_')) {
    print('🎉 FAKE TOKEN INTEGRATION WORKING!');
  } else {
    print('❌ Fake token not found');
  }
  print('=== END VERIFICATION ===');
}
```

The fake token system should now be working! If you're still not seeing tokens, try the manual debug functions above. 🚀