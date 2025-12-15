// Firebase Cloud Messaging Service Worker for Web Push Notifications
// This file enables background push notifications on web

importScripts('https://www.gstatic.com/firebasejs/10.10.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.10.0/firebase-messaging-compat.js');

// Initialize Firebase with your configuration
firebase.initializeApp({
  apiKey: "AIzaSyAoII4T4V27srX_deAxKtL_wI0U5MtE5EY",
  authDomain: "growtokyo-fd8ae.firebaseapp.com",
  projectId: "growtokyo-fd8ae",
  storageBucket: "growtokyo-fd8ae.firebasestorage.app",
  messagingSenderId: "766983345198",
  appId: "1:766983345198:web:7cf4c57e53580d4e9e7bbf",
  measurementId: "G-2R3EHW19JE"
});

// Retrieve an instance of Firebase Messaging
const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  
  // Customize notification here
  const notificationTitle = payload.notification?.title || payload.data?.subject || 'New Notification';
  const notificationOptions = {
    body: payload.notification?.body || payload.data?.description || 'You have a new notification',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    tag: payload.data?.id || 'notification',
    requireInteraction: true,
    data: payload.data
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

// Handle notification clicks
self.addEventListener('notificationclick', (event) => {
  console.log('[firebase-messaging-sw.js] Notification click received.', event);
  
  event.notification.close();
  
  // Open the app or focus existing window
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true })
      .then((clientList) => {
        // Check if there's already a window open
        for (const client of clientList) {
          if (client.url.includes(self.location.origin) && 'focus' in client) {
            return client.focus();
          }
        }
        // If no window is open, open a new one
        if (clients.openWindow) {
          return clients.openWindow('/');
        }
      })
  );
});
