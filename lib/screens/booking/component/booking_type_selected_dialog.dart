import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class BookingTypeSelectedDialog extends StatelessWidget {
  const BookingTypeSelectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.all(16),
      title: AppBar(
        title: Text(locale.confirm, style: boldTextStyle(size: 20)),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => finish(context),
          ),
        ],
      ).cornerRadiusWithClipRRect(20),
      titlePadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE6E5E5),
            radius: 45,
            child: Image.asset(ic_login_01, width: 45),
          ),
          24.height,
          Text(
            locale.guestBookingMessage,
            style: boldTextStyle(size: 16),
            textAlign: TextAlign.center,
          ),
          32.height,
          Row(
            children: [
              AppButton(
                text: locale.continueAsGuest,
                color: Colors.black,
                textColor: Colors.white,
                elevation: 0,
                onTap: () {
                  finish(context, true);
                },
              ).expand(),
              16.width,
              AppButton(
                text: locale.signIn,
                elevation: 0,
                shapeBorder: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                ),
                onTap: () {
                  finish(context, false);
                },
              ).expand(),
            ],
          ),
        ],
      ),
    );
  }
}
