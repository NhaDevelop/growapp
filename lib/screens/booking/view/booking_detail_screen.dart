import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:frezka/components/app_scaffold.dart';
import 'package:frezka/screens/booking/component/booking_information_component.dart';
import 'package:frezka/screens/booking/component/location_information_component.dart';
import 'package:frezka/screens/booking/component/payment_information_component.dart';
import 'package:frezka/utils/app_common.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../booking_repository.dart';
import '../component/booking_service_information_component.dart';
import '../model/booking_detail_response.dart';
import '../shimmer/booking_detail_shimmer.dart';

late VoidCallback onBookingDetailUpdate;

class BookingDetailScreen extends StatefulWidget {
  final int bookingId;
  final String? bookingStatus;

  BookingDetailScreen({required this.bookingId, this.bookingStatus});

  @override
  _BookingDetailScreenState createState() => _BookingDetailScreenState();
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
      return BookingDetailResponse(data: bookingDetailCached.firstWhere((element) => element.id == widget.bookingId));
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
            loadingWidget: BookingDetailShimmer(),
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: ErrorStateWidget(),
                onRetry: () {
                  appStore.setLoading(true);

                  init();
                  setState(() {});
                },
              );
            },
            onSuccess: (snap) {
              if (snap.data == null) {
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
                padding: EdgeInsets.all(16),
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  LocationInformationComponent(booking: snap.data!),
                  16.height,
                  BookingInformationComponent(
                    booking: snap.data!,
                    bookingStatus: widget.bookingStatus,
                    serviceList: snap.data!.serviceList.validate(),
                  ),
                  24.height,
                  BookingServiceInformationComponent(
                    serviceList: snap.data!.serviceList.validate(),
                    productList: snap.data!.productsInfo,
                    bookingStatus: widget.bookingStatus,
                  ),
                  8.height,
                  PaymentInformationComponent(booking: snap.data!),
                ],
                onSwipeRefresh: () async {
                  init();
                  setState(() {});

                  return await 2.seconds.delay;
                },
              );
            },
          ),
          Observer(builder: (context) => LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
