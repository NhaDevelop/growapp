# 🔧 API Connection Fix - FCM Token Update

## ❌ **The Problem**
Your API `http://192.168.0.137:8000/api/update-fcm-token` works in Postman but not in the app because:

- **App was using wrong URL**: When you run `flutter run --flavor stag`, it uses staging URL `https://grow-cms.xclabs.io` instead of your local server
- **URL mismatch**: App tried to hit staging server instead of `http://192.168.0.137:8000`

## ✅ **What I Fixed**

### **1. Updated Build Configuration**
- ✅ **Changed stag flavor** to point to your local server: `http://192.168.0.137:8000`
- ✅ **Updated `lib/utils/build_config.dart`** to use your local API for testing

### **2. Added Debug Logging**
- ✅ **Enhanced API logging** to show exactly which URL is being called
- ✅ **Added detailed error messages** to help debug connection issues

### **3. Created API Test Tools**
- ✅ **New test utility**: `APITestUtils` for testing API connection
- ✅ **Orange "TEST API CONNECTION" button** in notification settings screen
- ✅ **Network connectivity testing** to verify server reachability

## 🧪 **How to Test Now**

### **Method 1: Use Test Button**
1. Navigate to `NotificationSettingsScreen`
2. Click **orange "TEST API CONNECTION"** button
3. Check logs for detailed connection test results

### **Method 2: Check Logs**
When you try to update FCM token, you'll now see:
```
🔥 UPDATING FCM TOKEN TO SERVER
📍 Base URL: http://192.168.0.137:8000/api/
🎯 Full URL: http://192.168.0.137:8000/api/update-fcm-token
📦 Request: {fcm_token: fake_fcm_token_4107_1703123456789_grow_tokyo_app}
🔧 Method: PUT
```

### **Method 3: Manual Test**
```dart
import 'package:grow_tokyo_app/utils/api_test_utils.dart';

// Show current configuration
APITestUtils.showCurrentConfig();

// Test API connection
await APITestUtils.testFCMTokenAPI();
```

## 🎯 **Expected Results**

### **Success Logs:**
```
🧪 TESTING FCM TOKEN API CONNECTION
📍 Current App Flavor: AppFlavor.stag
🌐 Domain URL: http://192.168.0.137:8000
🔗 Base URL: http://192.168.0.137:8000/api/
🎯 FCM Token Endpoint: http://192.168.0.137:8000/api/update-fcm-token
📤 Sending test token: test_fcm_token_1703123456789
✅ FCM TOKEN API TEST SUCCESSFUL!
```

### **If Still Failing:**
The logs will show specific error details:
- **SocketException**: Server not running or network issue
- **401 Error**: Authentication problem
- **404 Error**: Endpoint not found

## 🔍 **Troubleshooting**

### **If API Still Doesn't Work:**

1. **Check server is running:**
```bash
# Make sure your Laravel server is running on port 8000
php artisan serve --host=192.168.0.137 --port=8000
```

2. **Verify network connectivity:**
- Can your device reach `192.168.0.137`?
- Are both device and server on same network?

3. **Check API endpoint:**
- Verify your Laravel route is: `PUT /api/update-fcm-token`
- Check if authentication is required

4. **Test with curl:**
```bash
curl -X PUT http://192.168.0.137:8000/api/update-fcm-token \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -d '{"fcm_token": "test_token"}'
```

## 🚀 **Ready to Test**

The app should now connect to your local API at `http://192.168.0.137:8000/api/update-fcm-token`. 

Use the orange "TEST API CONNECTION" button to verify the connection and check the detailed logs for any issues!

## 🔄 **Reverting Changes**

When you're done testing, remember to change the stag URL back to:
```dart
case AppFlavor.stag:
  return 'https://grow-cms.xclabs.io';
```