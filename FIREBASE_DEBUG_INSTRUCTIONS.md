# 🔍 Firebase Configuration Debug Instructions

## 🎯 IMMEDIATE DEBUG STEPS

### **Step 1: Run the Debug Code**

**Option A: Use Notification Settings (Recommended)**
1. Open your app and login
2. Go to **Notification Settings** screen
3. Tap **"🔍 DEBUG FIREBASE CONFIG (DETAILED)"** button
4. Check the console/logs for output

**Option B: Add Debug Code Manually**
Add this to your Flutter app (e.g., in a button or main.dart):

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void debugFirebaseConfig() async {
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
}
```

## 🎯 What Should Happen (Expected Output)

```
🔥 Firebase Project ID: growtokyo-fd8ae
✅ Using correct project: true
🔑 FCM Token: dB8snsNfSNmV7G9sEHrPOc:APA91bH...
```

## ❌ If You See Different Project ID

### **Problem: Wrong Firebase Project**
```
🔥 Firebase Project ID: growtokyo-staging
✅ Using correct project: false
❌ ERROR: App is using project growtokyo-staging but server expects growtokyo-fd8ae
```

### **Solution: Fix Configuration Files**

1. **Check Android Configuration:**
   ```bash
   # Check this file exists and has correct project_id
   android/app/google-services.json
   ```
   
   Should contain:
   ```json
   {
     "project_info": {
       "project_id": "growtokyo-fd8ae",
       "project_number": "766983345198"
     }
   }
   ```

2. **Check iOS Configuration (if applicable):**
   ```bash
   # Check this file exists and has correct PROJECT_ID
   ios/Runner/GoogleService-Info.plist
   ```

3. **Verify Package Name:**
   - Android: `com.growtokyo` (production)
   - iOS: `com.growtokyo`

## 🛠️ Configuration Files Status

### ✅ **Current Status (Already Fixed)**
I've already added the correct `google-services.json` file with:
- **Project ID:** `growtokyo-fd8ae` ✅
- **Project Number:** `766983345198` ✅
- **Package Name:** `com.growtokyo` ✅
- **API Key:** `AIzaSyCelDk0zZzNdAkVsbburRy_IaBMH2cNI2Y` ✅

### 📁 **File Locations:**
- ✅ `android/app/google-services.json` (Production config)
- ✅ `android/app/src/prod/google-services.json` (Backup)
- ✅ `android/app/src/stag/google-services.json` (Staging config)

## 🔧 Troubleshooting Steps

### **If Debug Shows Wrong Project:**

1. **Clean and Rebuild:**
   ```bash
   flutter clean
   flutter pub get
   cd android && ./gradlew clean
   flutter build apk --flavor prod
   ```

2. **Check Build Flavor:**
   - Ensure you're building with `--flavor prod`
   - Verify `BuildConfig.appFlavor = AppFlavor.prod`

3. **Verify File Contents:**
   ```bash
   # Check the file contains growtokyo-fd8ae
   cat android/app/google-services.json | grep project_id
   ```

### **If No FCM Token Generated:**

1. **Check Permissions:**
   - Notification permissions granted
   - Internet connectivity
   - Firebase properly initialized

2. **Check Firebase Initialization:**
   ```dart
   // Ensure Firebase is initialized before getting token
   await Firebase.initializeApp();
   String? token = await FirebaseMessaging.instance.getToken();
   ```

## 📱 Testing Instructions

### **Step 1: Run Debug**
Use the debug button in Notification Settings or add the debug code manually.

### **Step 2: Check Output**
Look for these specific lines in your console/logs:
```
🔥 Firebase Project ID: [SHOULD BE growtokyo-fd8ae]
✅ Using correct project: [SHOULD BE true]
🔑 FCM Token: [SHOULD BE long string starting with letters/numbers]
```

### **Step 3: Report Results**
Tell the backend team exactly what you see:
- What Project ID is shown?
- Is "Using correct project" true or false?
- Is there an FCM token generated?
- Any error messages?

## 🎯 Expected vs Actual Comparison

| Item | Expected | Check |
|------|----------|-------|
| Project ID | `growtokyo-fd8ae` | ✅ |
| Package Name | `com.growtokyo` | ✅ |
| FCM Token | 150+ char string | ❓ |
| Token Type | Real (not fake) | ❓ |

## 🚨 Critical Issues to Look For

1. **Wrong Project ID:**
   - Shows `growtokyo-staging` instead of `growtokyo-fd8ae`
   - Shows any other project ID

2. **No FCM Token:**
   - Token is null or empty
   - Token starts with `fake_fcm_token_`

3. **Configuration Mismatch:**
   - Package name doesn't match
   - API keys don't match

## 📞 Next Steps

After running the debug:

1. **If Everything is Correct:**
   - Project ID: `growtokyo-fd8ae` ✅
   - FCM Token: Generated ✅
   - → Your configuration is correct, backend should accept tokens

2. **If Issues Found:**
   - Share the exact debug output with backend team
   - Follow the troubleshooting steps above
   - Use the fix buttons in Notification Settings

## 🎉 Success Indicators

You'll know it's working when:
- ✅ Debug shows `growtokyo-fd8ae` project
- ✅ FCM token is generated (150+ characters)
- ✅ Backend accepts the tokens without errors
- ✅ Push notifications work properly

**Run the debug now and share the exact output!** 🔍