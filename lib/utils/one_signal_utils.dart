import 'package:flutter/material.dart';
import 'package:frezka/main.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../configs.dart';
import '../screens/booking/view/booking_detail_screen.dart';
import '../screens/order/view/order_detail_screen.dart';

Future<void> initOneSignal() async {
  ///Initialize
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(ONESIGNAL_APP_ID);
  OneSignal.Notifications.requestPermission(true);
  OneSignal.User.pushSubscription.optIn();

  ///Handle Navigation
  OneSignal.Notifications.addClickListener((event) {
    log("${event.jsonRepresentation()}");
    if (event.notification.additionalData != null) {
      final additionalData = event.notification.additionalData!['additional_data'];

      if (event.notification.additionalData!['additional_data'].containsKey('id')) {
        int? notId = event.notification.additionalData!['additional_data']["id"];

        if (event.notification.additionalData!['additional_data']['notification_group'] == 'shop') {
          navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => OrderDetailScreen(orderId: notId.validate(), orderCode: additionalData['order_code'])));
        } else {
          navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => BookingDetailScreen(bookingId: notId.validate())));
        }
      }
    }
  });

  ///Save Player Id
  saveOneSignalPlayerId();
}

Future<void> saveOneSignalPlayerId() async {
  if (appStore.isLoggedIn) {
    await OneSignal.login(userStore.userEmail.toString()).then((value) async {
      if (OneSignal.User.pushSubscription.id.validate().isNotEmpty) {
        userStore.setPlayerId(OneSignal.User.pushSubscription.id.validate());
      }
    }).catchError((e) {
      log('Error saving subscription id - $e');
    });
  }
}
