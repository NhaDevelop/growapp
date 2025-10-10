# Fake FCM Token Testing Guide

## ✅ What's Now Working

I've updated the FCM integration to **automatically generate and store fake FCM tokens** when Firebase Messaging is not available. This allows you to test the entire FCM token flow without needing the actual Firebase dependency.

## 🔧 How It Works

### **1. Automatic Fake Token Generation**
When a user logs in and Firebase Messaging is not available:
- A fake FCM token is automatically generated
- Format: `fake_fcm_token_{userId}_{timestamp}_grow_tokyo_app`
- The token is stored in UserStore and shared preferences
- The token is sent to your backend API

### **2. Fake Token Format Example**
```
fake_fcm_token_4107_1703123456789_grow_tokyo_app
```

### **3. What Happens on Login**
1. User logs in successfully
2. FCM initialization is attempted
3. Since Firebase Messaging is not available, a fake token is generated
4. Fake token is stored locally
5. Fake token is sent to `/api/update-fcm-token` endpoint

## 🧪 Testing the Integration

### **Method 1: Check Logs After Login**
After a user logs in, check the Flutter logs for:
```
I/flutter: Firebase Messaging not available - using fake token for testing
I/flutter: Generated fake token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: Fake token saved to UserStore
I/flutter: Fake FCM token updated successfully (for testing)
```

### **Method 2: Use the Test Screen**
1. Navigate to the `NotificationSettingsScreen`
2. You'll see the fake token displayed with "(FAKE TOKEN FOR TESTING)" suffix
3. Click "Test Fake Token Generation" to manually generate a new fake token
4. Click "Update FCM Token" to send the fake token to your backend
5. Click "Reload User Data" to fetch user data from `/api/notification-user-get-point`

### **Method 3: Check UserStore**
You can check if the fake token is stored by looking at:
```dart
print('Stored FCM Token: ${userStore.fcmToken}');
```

## 📱 How to Add Test Screen to Your App

Add this to any screen where you want to test FCM:

```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationSettingsScreen(),
      ),
    );
  },
  child: const Text('Test FCM Integration'),
)
```

## 🔍 What You Should See

### **In the Test Screen:**
- **User Information**: Shows user ID, name, points, and FCM token status
- **FCM Token Information**: Shows "Set" for local token and "Available" for device token
- **Token Preview**: Shows the fake token with "(FAKE TOKEN FOR TESTING)" label

### **In the Logs:**
```
I/flutter: === TESTING FAKE FCM TOKEN GENERATION ===
I/flutter: Generated fake token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: Fake token saved to UserStore
I/flutter: Retrieved token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: UserStore FCM token: fake_fcm_token_4107_1703123456789_grow_tokyo_app
I/flutter: === FAKE TOKEN TEST COMPLETE ===
```

### **In Your Backend:**
You should receive API calls to:
1. `PUT /api/update-fcm-token` with the fake token
2. `GET /api/notification-user-get-point` requests

## 🎯 Verification Checklist

- [ ] User logs in successfully
- [ ] Fake FCM token is generated (check logs)
- [ ] Token is stored in UserStore (`userStore.fcmToken` is not empty)
- [ ] Token is sent to backend (`/api/update-fcm-token` receives the fake token)
- [ ] Test screen shows the fake token with "(FAKE TOKEN FOR TESTING)" label
- [ ] "Update FCM Token" button works and shows success message
- [ ] Backend receives the fake token in API calls

## 🔄 Token Refresh Testing

The fake tokens will be regenerated:
- Every time a user logs in
- When "Refresh FCM Token" is clicked
- When "Test Fake Token Generation" is clicked

Each new token will have a different timestamp, so you can verify that token refresh is working.

## 🚀 Ready for Production

When you're ready to use real FCM tokens:
1. Run `flutter pub get` to install `firebase_messaging`
2. The code will automatically switch to using real FCM tokens
3. All the same APIs and flows will work with real tokens
4. Remove the "(FAKE TOKEN FOR TESTING)" labels if desired

## 🛠️ Backend Implementation

Your backend should handle both fake and real tokens the same way. The fake tokens are just strings that follow a predictable format, so your notification system can easily identify and handle them appropriately.

**Example backend logic:**
```php
if (strpos($fcm_token, 'fake_fcm_token_') === 0) {
    // This is a fake token for testing
    // Log it or handle it differently
    error_log("Received fake FCM token for testing: " . $fcm_token);
} else {
    // This is a real FCM token
    // Use it for actual push notifications
}
```

The integration is now fully testable with fake data! 🎉