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
// COMMENTED OUT FOR VERSION 1.0.17 (NO EVALUATION FEATURES)
// import '../../evaluation/evaluation_repository.dart';
// import '../../evaluation/view/stylist_evaluation_screen.dart';
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

                  // COMMENTED OUT FOR VERSION 1.0.17 (NO EVALUATION FEATURES)
                  // Handle evaluation notification
                  // if (notiGroup == "evaluation") {
                  //   return GestureDetector(
                  //     onTap: () async {
                  //       final bookingId = notificationData
                  //           .data!.notificationDetail!.id
                  //           .validate();
                  //
                  //       try {
                  //         log('🌐 Fetching questionnaire content from API...');
                  //         final evaluationData =
                  //             await fetchQuestionnaireContent();
                  //
                  //         StylistEvaluationScreen(
                  //           evaluationData: evaluationData,
                  //           bookingId: bookingId,
                  //           submitStatus:
                  //               null, // No submit status in this format
                  //         ).launch(context);
                  //       } catch (e) {
                  //         log('❌ Failed to fetch questionnaire: $e');
                  //         toast('Failed to load evaluation form');
                  //       }
                  //     },
                  //     child: NotificationWidget(
                  //         key: ValueKey('notif_${notificationData.id}'),
                  //         notificationData: notificationData),
                  //   );
                  // }

                  return GestureDetector(
                    onTap: () async {
                      // Skip notifications with completely null data (backend bug)
                      if (notificationData.data == null) {
                        return; // Silently skip - this is a backend issue
                      }

                      // Check if notification has detail (old structure)
                      if (notificationData.data!.notificationDetail == null) {
                        final subject = notificationData.data?.subject ?? '';

                        // COMMENTED OUT FOR VERSION 1.0.17 (NO EVALUATION FEATURES)
                        // Special handling for backend evaluation notifications
                        // if (subject
                        //         .toLowerCase()\n                        //         .contains('stylist evaluation') ||
                        //     subject.toLowerCase().contains('evaluation') ||
                        //     subject.toLowerCase().contains('questionnair')) {
                        //   // Backend sends flat structure: {"subject": "...", "booking_id": 123}
                        //   final bookingId = notificationData.data?.bookingId;
                        //
                        //   if (bookingId == null) {
                        //     log('⚠️ Questionnair notification missing booking ID');
                        //     return;
                        //   }
                        //
                        //   log('🔧 Opening evaluation for booking ID: $bookingId');
                        //
                        //   try {
                        //     log('🌐 Fetching questionnaire content from API...');
                        //     final evaluationData =
                        //         await fetchQuestionnaireContent();
                        //
                        //     // IMPORTANT: Pass null for submitStatus to force API check
                        //     // The notification's submit_status is unreliable
                        //     await StylistEvaluationScreen(
                        //       evaluationData: evaluationData,
                        //       bookingId: bookingId,
                        //       submitStatus:
                        //           null, // Always check via API, don't trust notification
                        //     ).launch(context);
                        //
                        //     // Refresh notification list after returning from evaluation screen
                        //     init(flag: true);
                        //   } catch (e) {
                        //     log('❌ Failed to fetch questionnaire: $e');
                        //     toast('Failed to load evaluation form');
                        //   }
                        //   return;
                        // }

                        // For booking/appointment notifications, fetch detail from external API
                        if (subject.toLowerCase().contains('booking') ||
                            subject.toLowerCase().contains('appointment')) {
                          log('🔧 Fetching notification detail from external API...');
                          appStore.setLoading(true);

                          try {
                            final detail = await getNotificationDetail(
                                notificationData.id.validate());

                            appStore.setLoading(false);

                            if (detail != null && detail.id != null) {
                              log('✅ Fetched notification detail, opening booking #${detail.id}');

                              // Update the notification data with fetched detail
                              notificationData.data!.notificationDetail =
                                  detail;

                              // Navigate to booking detail screen
                              BookingDetailScreen(bookingId: detail.id!)
                                  .launch(context);
                            } else {
                              log('❌ Failed to fetch notification detail');
                              toast('Unable to load booking details');
                            }
                          } catch (e) {
                            appStore.setLoading(false);
                            log('❌ Error fetching notification detail: $e');
                            toast('Unable to load booking details');
                          }
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
                    child: NotificationWidget(
                        key: ValueKey('notif_${notificationData.id}'),
                        notificationData: notificationData),
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
