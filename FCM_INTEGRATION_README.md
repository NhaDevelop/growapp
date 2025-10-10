# FCM Token Integration for Push Notifications

This document explains the FCM (Firebase Cloud Messaging) token integration that has been added to the Grow Tokyo app for push notification support.

## Overview

The integration includes:
1. **API Endpoints**: Two new endpoints for FCM token management
2. **Data Models**: Updated user models to include FCM token
3. **Service Layer**: FCM service for token management
4. **UI Components**: Example screen for testing FCM functionality

## API Endpoints

### 1. Update FCM Token
- **Endpoint**: `/api/update-fcm-token`
- **Method**: `PUT`
- **Purpose**: Update the user's FCM token in the backend
- **Request Body**:
```json
{
  "fcm_token": "user_fcm_token_here"
}
```

### 2. Get User Notification Data
- **Endpoint**: `/api/notification-user-get-point`
- **Method**: `GET`
- **Purpose**: Retrieve user data including points and FCM token status
- **Response**:
```json
{
  "id": 4107,
  "name": "Sansan Developer",
  "points": 69,
  "fcm_token": "user_fcm_token_or_empty_string"
}
```

## Implementation Details

### 1. Updated Models

#### UserData Model (`lib/screens/auth/model/user_data_model.dart`)
- Added `fcmToken` field to store FCM token
- Updated JSON serialization/deserialization

#### UserStore (`lib/store/user_store.dart`)
- Added `fcmToken` observable field
- Added `setFcmToken()` method for updating token

#### NotificationUserResponse Model (`lib/models/notification_user_response.dart`)
- New model for handling notification user data response

### 2. API Integration (`lib/network/rest_apis.dart`)

```dart
// Update FCM token
Future<Map<String, dynamic>> updateFcmToken({required String fcmToken}) async

// Get user notification data
Future<NotificationUserResponse> getNotificationUserGetPoint() async
```

### 3. FCM Service (`lib/services/fcm_service.dart`)

The FCM service handles:
- FCM initialization and permission requests
- Token generation and refresh
- Automatic token updates to server
- Message handling (foreground, background, app opened)

Key methods:
```dart
FCMService.initializeFCM()          // Initialize FCM
FCMService.getCurrentToken()        // Get current token
FCMService.updateFcmTokenOnServer() // Update token on server
FCMService.setupMessageHandlers()   // Setup message handlers
```

### 4. Integration Points

#### Login Flow (`lib/screens/auth/auth_repository.dart`)
- FCM is automatically initialized after successful login
- Token is sent to server when available

#### App Initialization (`lib/main.dart`)
- FCM token is loaded from shared preferences on app start

## Usage Examples

### 1. Initialize FCM (Automatic)
FCM is automatically initialized when:
- User logs in successfully
- App starts (if user is already logged in)

### 2. Manual Token Update
```dart
// Get current token
String? token = await FCMService.getCurrentToken();

// Update token on server
if (token != null) {
  await updateFcmToken(fcmToken: token);
}
```

### 3. Get User Notification Data
```dart
try {
  NotificationUserResponse userData = await getNotificationUserGetPoint();
  print('User: ${userData.name}');
  print('Points: ${userData.points}');
  print('FCM Token Status: ${userData.fcmToken?.isNotEmpty == true ? "Active" : "Not Set"}');
} catch (e) {
  print('Error: $e');
}
```

## Testing

### Notification Settings Screen
A test screen has been created at `lib/screens/notification/notification_settings_screen.dart` that demonstrates:
- Displaying user notification data
- Showing FCM token status
- Updating FCM token
- Refreshing token

To use this screen, add it to your navigation:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NotificationSettingsScreen()),
);
```

## Backend Requirements

The backend should implement these endpoints:

### 1. PUT /api/update-fcm-token
```php
// Expected request
{
  "fcm_token": "string"
}

// Expected response
{
  "status": true,
  "message": "FCM token updated successfully"
}
```

### 2. GET /api/notification-user-get-point
```php
// Expected response
{
  "status": true,
  "data": {
    "id": 4107,
    "name": "Sansan Developer", 
    "points": 69,
    "fcm_token": "user_fcm_token_or_empty_string"
  }
}
```

## Database Schema

Add FCM token column to your users table:
```sql
ALTER TABLE users ADD COLUMN fcm_token VARCHAR(255) NULL;
```

## Security Considerations

1. **Token Validation**: Validate FCM tokens on the backend
2. **User Authentication**: Ensure only authenticated users can update their FCM tokens
3. **Token Expiry**: Handle token refresh automatically
4. **Privacy**: Don't log FCM tokens in plain text

## Troubleshooting

### Common Issues

1. **Token not generated**: Check Firebase configuration and permissions
2. **Token not updating**: Verify network connectivity and authentication
3. **Notifications not received**: Check FCM token validity and server implementation

### Debug Steps

1. Check FCM token in app logs
2. Verify token is sent to server
3. Test notification sending from Firebase Console
4. Check device notification permissions

## Next Steps

1. Implement push notification handling in your backend
2. Add notification categories and targeting
3. Implement notification analytics
4. Add notification preferences UI
5. Handle notification deep linking

## Dependencies

Make sure these dependencies are added to your `pubspec.yaml`:
```yaml
dependencies:
  firebase_messaging: ^14.7.9
  firebase_core: ^2.24.2
```

## Firebase Setup

1. Add your app to Firebase Console
2. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
3. Configure Firebase in your app
4. Enable Cloud Messaging in Firebase Console