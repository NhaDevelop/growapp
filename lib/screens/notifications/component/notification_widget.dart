import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/screens/evaluation/evaluation_repository.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/common_base.dart';
import '../../../utils/images.dart';
import '../model/notification_model.dart';

class NotificationWidget extends StatefulWidget {
  final NotificationData notificationData;

  const NotificationWidget({super.key, required this.notificationData});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool? isSubmitted;

  @override
  void initState() {
    super.initState();
    _checkSubmissionStatus();
  }

  @override
  void didUpdateWidget(NotificationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-check status whenever the parent rebuilds (e.g., after evaluation submission)
    // This ensures the icon updates immediately when returning from evaluation screen
    _checkSubmissionStatus();
  }

  Future<void> _checkSubmissionStatus() async {
    final subject = widget.notificationData.data?.subject;

    // Check if it's an evaluation notification by subject
    final isEvaluationNotification =
        subject?.toLowerCase().contains('questionnair') ?? false;

    if (!isEvaluationNotification) {
      return; // Not an evaluation, skip
    }

    // Try to get booking ID from different possible locations
    int? bookingId;

    // First try: notificationDetail.id (old structure)
    bookingId = widget.notificationData.data?.notificationDetail?.id;

    // Second try: direct bookingId field (new structure)
    bookingId ??= widget.notificationData.data?.bookingId;

    if (bookingId != null) {
      // Use local storage ONLY - backend sync happens in evaluation screen
      final submitted = await isEvaluationSubmittedLocally(bookingId);
      if (mounted) {
        setState(() {
          isSubmitted = submitted;
        });
      }
    } else {
      log('   ⚠️ No booking ID found - cannot check status');
    }
  }

  Color _getBGColor(BuildContext context) {
    if (widget.notificationData.readAt != null) {
      return context.scaffoldBackgroundColor;
    } else {
      return context.cardColor;
    }
  }

  Widget? _buildStatusIcon() {
    if (isSubmitted == null) return null;

    if (isSubmitted!) {
      // Submitted - Grey checkmark (like read messages in Messenger)
      return Icon(
        Icons.check_circle,
        color: Colors.grey.shade600,
        size: 18,
      );
    } else {
      // Pending - Grey dot (like unread messages in Messenger)
      return Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          shape: BoxShape.circle,
        ),
      );
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
          const CachedImageWidget(url: ic_notification_user, height: 40),
          16.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Show booking ID from either notificationDetail or direct bookingId field
                  Builder(
                    builder: (context) {
                      int? bookingId;

                      // Try notificationDetail first (old structure)
                      if (widget.notificationData.data?.notificationDetail !=
                          null) {
                        bookingId = widget
                            .notificationData.data!.notificationDetail!.id;
                      }

                      // Try direct bookingId field (new structure - questionnair)
                      bookingId ??= widget.notificationData.data?.bookingId;

                      if (bookingId != null) {
                        return Text('#$bookingId',
                                style: boldTextStyle(size: 12))
                            .expand();
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                  // Use data.date for questionnair notifications (local time)
                  // Use createdAt for other notifications (UTC time)
                  Builder(
                    builder: (context) {
                      final isQuestionnair = widget
                              .notificationData.data?.subject
                              ?.toLowerCase()
                              .contains('questionnair') ??
                          false;
                      final dateTime = isQuestionnair &&
                              widget.notificationData.data?.date != null
                          ? widget.notificationData.data!.date!
                          : widget.notificationData.createdAt.validate();
                      return Text(formatDate(dateTime),
                          style: secondaryTextStyle());
                    },
                  ),
                ],
              ),
              8.height,
              Row(
                children: [
                  Expanded(
                    child: Text(widget.notificationData.data?.subject ?? '',
                        style: secondaryTextStyle(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis),
                  ),
                  if (_buildStatusIcon() != null) ...[
                    8.width,
                    _buildStatusIcon()!,
                  ],
                ],
              ),
            ],
          ).expand(),
        ],
      ),
    );
  }
}
