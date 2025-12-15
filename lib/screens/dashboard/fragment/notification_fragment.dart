import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/screens/notifications/component/happy_birthday_notification_widget.dart';
import 'package:grow_tokyo_app/screens/profile/view/html_content_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../booking/view/booking_detail_screen.dart';
import '../../evaluation/model/evaluation_dummy_data.dart';
import '../../evaluation/view/stylist_evaluation_screen.dart';
import '../../notifications/component/notification_widget.dart';
import '../../notifications/model/notification_model.dart';
import '../../notifications/notification_repository.dart';
import '../../notifications/shimmer/notification_shimmer.dart';
import '../../order/view/order_detail_screen.dart';

class NotificationFragment extends StatefulWidget {
  const NotificationFragment({super.key});

  @override
  State<NotificationFragment> createState() => _NotificationFragmentState();
}

class _NotificationFragmentState extends State<NotificationFragment> {
  Future<List<NotificationData>>? future;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init({bool flag = false}) async {
    future = getNotification(markAsRead: true);
    if (flag) setState(() {});
  }

  /// Create a dummy evaluation notification for testing
  // COMMENTED OUT - No longer using dummy notifications
  // NotificationData _createDummyEvaluationNotification() {
  //   return NotificationData(
  //     id: 'dummy-evaluation-001',
  //     type: 'App\\Notifications\\CommonNotification',
  //     notifiableId: userStore.userId,
  //     notifiableType: 'App\\Models\\User',
  //     readAt: null, // Always unread for visibility
  //     createdAt: DateTime.now().toIso8601String(),
  //     updatedAt: DateTime.now().toIso8601String(),
  //     data: NotificationModel(
  //       subject: '⭐ Please evaluate your recent visit',
  //       notificationDetail: NotificationDetail(
  //         id: 10556, // Booking ID
  //         type: 'stylist_evaluation',
  //         notificationType: 'stylist_evaluation',
  //         notificationGroup: 'evaluation',
  //         description: 'We would love to hear your feedback about your stylist',
  //         bookingDate: '31/12/2025',
  //         bookingTime: '10:00 AM',
  //         employeeName: 'Any Japanese',
  //       ),
  //     ),
  //   );
  // }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarWidget: commonAppBarWidget(
        context,
        title: locale.notifications,
        appBarHeight: 70,
        showLeadingIcon: true,
        roundCornerShape: true,
      ),
      body: Stack(
        children: [
          SnapHelperWidget<List<NotificationData>>(
            future: future,
            initialData: notificationListCached,
            loadingWidget: const NotificationShimmer(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                imageWidget: const ErrorStateWidget(),
                retryText: locale.reload,
                onRetry: () {
                  appStore.setLoading(true);

                  init(flag: true);
                },
              );
            },
            onSuccess: (list) {
              // Add dummy evaluation notification at the top
              // COMMENTED OUT - Using real backend notifications only
              // final notificationsWithDummy = [
              //   _createDummyEvaluationNotification(),
              //   ...list,
              // ];

              return AnimatedListView(
                shrinkWrap: true,
                itemCount:
                    list.length, // Changed from notificationsWithDummy.length
                padding: const EdgeInsets.only(top: 8),
                slideConfiguration: SlideConfiguration(
                    duration: 400.milliseconds, delay: 50.milliseconds),
                listAnimationType: ListAnimationType.FadeIn,
                fadeInConfiguration: FadeInConfiguration(duration: 2.seconds),
                physics: const AlwaysScrollableScrollPhysics(),
                emptyWidget: NoDataWidget(
                  title: locale.noNotifications,
                  subTitle: locale.weLlNotifyYouOnce,
                  imageWidget: const EmptyStateWidget(),
                ),
                onSwipeRefresh: () async {
                  appStore.setLoading(true);

                  init(flag: true);
                },
                itemBuilder: (context, index) {
                  NotificationData notificationData = list[index];
                  final notiGroup = notificationData
                      .data?.notificationDetail?.notificationGroup;

                  if (notiGroup == "happy_birthday") {
                    return GestureDetector(
                      onTap: () => HtmlContentScreen(
                        title: locale.happyBirthday,
                        htmlData: notificationData
                            .data!.notificationDetail!.content
                            .validate(),
                      ).launch(context),
                      child: HappyBirthdayNotificationWidget(
                          notificationData: notificationData),
                    );
                  }

                  // Handle evaluation notification
                  if (notiGroup == "evaluation") {
                    return GestureDetector(
                      onTap: () {
                        final bookingId = notificationData
                            .data!.notificationDetail!.id
                            .validate();
                        StylistEvaluationScreen(
                          evaluationData: getDummyEvaluationData(),
                          bookingId: bookingId,
                        ).launch(context);
                      },
                      child: NotificationWidget(
                          notificationData: notificationData),
                    );
                  }

                  return GestureDetector(
                    onTap: () async {
                      // Add null safety checks
                      if (notificationData.data == null ||
                          notificationData.data!.notificationDetail == null) {
                        log('⚠️ Notification data is incomplete:');
                        log('  - Notification ID: ${notificationData.id}');
                        log('  - Subject: ${notificationData.data?.subject ?? "(no subject)"}');
                        log('  - Has data: ${notificationData.data != null}');
                        log('  - Has detail: ${notificationData.data?.notificationDetail != null}');

                        // Special handling for backend evaluation notifications
                        final subject = notificationData.data?.subject ?? '';
                        if (subject
                                .toLowerCase()
                                .contains('stylist evaluation') ||
                            subject.toLowerCase().contains('evaluation')) {
                          // Backend sends flat structure: {"subject": "...", "booking_id": 123}
                          final bookingId =
                              notificationData.data?.bookingId ?? 10556;
                          log('🔧 Opening evaluation for booking ID: $bookingId');

                          StylistEvaluationScreen(
                            evaluationData: getDummyEvaluationData(),
                            bookingId: bookingId,
                          ).launch(context);
                          return;
                        }

                        log('  - Group: ${notificationData.data?.notificationDetail?.notificationGroup ?? "(no group)"}');
                        toast(
                            'This notification cannot be opened - missing data from server');
                        return;
                      }

                      final id = notificationData.data!.notificationDetail!.id
                          .validate();
                      if (id < 0) return;
                      final orderCode = notificationData
                          .data!.notificationDetail!.orderCode
                          .validate();

                      if (notiGroup == "shop") {
                        OrderDetailScreen(orderId: id, orderCode: orderCode)
                            .launch(context,
                                pageRouteAnimation: PageRouteAnimation.Fade);
                      } else {
                        BookingDetailScreen(bookingId: id).launch(context);
                      }
                    },
                    child:
                        NotificationWidget(notificationData: notificationData),
                  );
                },
              );
            },
          ),
          Observer(
              builder: (context) =>
                  const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
