import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/default_card.dart';
import 'package:grow_tokyo_app/screens/booking/component/service_item_component.dart';
import 'package:grow_tokyo_app/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../booking_repository.dart';
import '../model/booking_detail_response.dart';
import '../shimmer/booking_detail_shimmer.dart';

late VoidCallback onBookingDetailUpdate;

class BookingDetailScreen extends StatefulWidget {
  final int bookingId;
  final String? bookingStatus;

  const BookingDetailScreen(
      {super.key, required this.bookingId, this.bookingStatus});

  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  Future<BookingDetailResponse>? future;

  @override
  void initState() {
    super.initState();
    init();

    onBookingDetailUpdate = () {
      init(flag: true);
    };
  }

  void init({bool flag = false}) async {
    /// Booking Detail API
    future = getBookingDetail(bookingId: widget.bookingId.validate());
    if (flag) setState(() {});
  }

  BookingDetailResponse? getInitialData() {
    if (bookingDetailCached.any((element) => element.id == widget.bookingId)) {
      return BookingDetailResponse(
          data: bookingDetailCached
              .firstWhere((element) => element.id == widget.bookingId));
    } else {
      return null;
    }
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
        title: '#${widget.bookingId}',
        appBarHeight: 70,
        roundCornerShape: true,
        showLeadingIcon: Navigator.canPop(context),
      ),
      body: Stack(
        children: [
          SnapHelperWidget<BookingDetailResponse>(
            future: future,
            initialData: getInitialData(),
            loadingWidget: const BookingDetailShimmer(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              );
            },
            onSuccess: (snap) {
              final data = snap.data;
              if (data == null) {
                return NoDataWidget(
                  title: locale.noDetailsFound,
                  retryText: locale.reload,
                  onRetry: () {
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  },
                );
              }

              return AnimatedScrollView(
                padding: const EdgeInsets.all(16),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Text(locale.yourInformation, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: [
                        _RowData(
                          title: locale.name,
                          value: userStore.userFullName,
                        ),
                        8.height,
                        _RowData(
                          title: locale.contactNumber,
                          value: userStore.userContactNumber,
                        ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(locale.timeSlot, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: _RowData(
                      title: '${locale.date} & ${locale.time}',
                      value: '${data.bookingDate} at ${data.bookingTime}',
                    ),
                  ),
                  16.height,
                  Text(locale.locationInformation, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: [
                        _RowData(
                          title: locale.branchName,
                          value: data.branchName.validate(),
                        ),
                        // 8.height,
                        // _RowData(
                        //   title: locale.address,
                        //   value: data.branchAddress.validate(),
                        // ),
                      ],
                    ),
                  ),
                  16.height,
                  Text(locale.stylist, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: _RowData(
                      title: locale.stylist,
                      value: data.employeeName.validate(),
                    ),
                  ),
                  16.height,
                  Text(locale.services, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: data.serviceList
                          .validate()
                          .map((e) => ServiceItemComponent(
                                key: ValueKey(e.id),
                                service: e,
                              ).paddingSymmetric(vertical: 4))
                          .toList(),
                    ),
                  ),
                  16.height,
                  Text(locale.serviceNote, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    width: context.width(),
                    child: Text(data.note ?? 'N/A'),
                  ),
                  16.height,
                  Text(locale.paymentDetails, style: secondaryTextStyle()),
                  12.height,
                  DefaultCard(
                    child: Column(
                      children: [
                        if (data.referralRewardPercent.validate() > 0) ...[
                          _RowData(
                            title: locale.referralDiscount,
                            value: '-${data.referralRewardPercent}%',
                          ),
                          8.height,
                        ],
                        if (data.couponDiscountPercentage.validate() > 0) ...[
                          _RowData(
                            title: locale.couponDiscount,
                            value: '-${data.couponDiscountPercentage}%',
                          ),
                          8.height,
                        ],
                        if (data.amountPaidByCredit.validate() > 0) ...[
                          _RowData(
                            title: locale.points,
                            value: 'XXX', //TODO: add value
                          ),
                          8.height,
                        ],
                        _RowData(
                          title: locale.paymentMethod,
                          value: locale.payAtSalon,
                        ),
                      ],
                    ),
                  ),
                ],
                onSwipeRefresh: () async {
                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
              );
            },
          ),
          Observer(
            builder: (context) =>
                const LoaderWidget().visible(appStore.isLoading),
          ),
        ],
      ),
    );
  }
}

class _RowData extends StatelessWidget {
  final String title;
  final String value;

  const _RowData({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: secondaryTextStyle()),
        16.width,
        Flexible(child: Marquee(child: Text(value, style: boldTextStyle()))),
      ],
    );
  }
}
