import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../model/notification_model.dart';

class HappyBirthdayNotificationWidget extends StatelessWidget {
  final NotificationData notificationData;

  const HappyBirthdayNotificationWidget(
      {super.key, required this.notificationData});

  Color _getBGColor(BuildContext context) {
    if (notificationData.readAt != null) {
      return context.scaffoldBackgroundColor;
    } else {
      return context.cardColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: boxDecorationDefault(
        color: _getBGColor(context),
        borderRadius: radius(0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CachedImageWidget(url: app_logo, height: 40, radius: 20),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (notificationData.data != null &&
                      notificationData.data!.notificationDetail != null)
                    Text(notificationData.data!.subject.validate(),
                            style: boldTextStyle(size: 12),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis)
                        .expand(),
                  Text(formatDate(notificationData.createdAt.validate()),
                      style: secondaryTextStyle()),
                ],
              ),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
