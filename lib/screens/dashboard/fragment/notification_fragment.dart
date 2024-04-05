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
              return AnimatedListView(
                shrinkWrap: true,
                itemCount: list.length,
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

                  return GestureDetector(
                    onTap: () async {
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
