import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/common_bottom_price_widget.dart';
import 'package:grow_tokyo_app/components/custom_stepper.dart';
import 'package:grow_tokyo_app/screens/booking/shimmer/booking_step2_shimmer.dart';
import 'package:grow_tokyo_app/screens/category/category_repository.dart';
import 'package:grow_tokyo_app/screens/booking/component/select_category_item_component.dart';
import 'package:grow_tokyo_app/screens/category/model/category_response.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/loader_widget.dart';
import '../../../main.dart';

class BookingStep2Component extends StatefulWidget {
  final bool isReschedule;

  const BookingStep2Component({super.key, this.isReschedule = false});

  @override
  State<BookingStep2Component> createState() => _BookingStep2ComponentState();
}

class _BookingStep2ComponentState extends State<BookingStep2Component> {
  UniqueKey key = UniqueKey();
  Future<List<CategoryData>>? future;
  int page = 1;
  bool isLastPage = false;
  List<CategoryData> categoryList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getCategoryList(
      page: page,
      list: categoryList,
      isStoreCached: true,
      lastPageCallBack: (val) {
        isLastPage = val;
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SnapHelperWidget<List<CategoryData>>(
            future: future,
            initialData: categoryListCached,
            loadingWidget: const BookingStep2Shimmer(),
            onSuccess: (list) {
              if (list.isEmpty) {
                return NoDataWidget(
                  title: locale.noCategoryFound,
                  retryText: locale.reload,
                  onRetry: () {
                    page = 1;
                    appStore.setLoading(true);

                    init();
                    setState(() {});
                  },
                );
              }

              return AnimatedScrollView(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 70, bottom: 100),
                  listAnimationType: ListAnimationType.Scale,
                  physics: const AlwaysScrollableScrollPhysics(),
                  onSwipeRefresh: () async {
                    page = 1;

                    init();
                    setState(() {});

                    return await 2.seconds.delay;
                  },
                  onNextPage: () {
                    if (!isLastPage) {
                      page++;
                      appStore.setLoading(true);

                      init();
                      setState(() {});
                    }
                  },
                  children: [
                    Text(
                      locale.chooseYourStylist,
                      style: primaryTextStyle(weight: FontWeight.w500),
                    ),
                    16.height,
                    AnimatedWrap(
                      key: key,
                      runSpacing: 16,
                      itemCount: list.length,
                      listAnimationType: ListAnimationType.Scale,
                      scaleConfiguration: ScaleConfiguration(
                          duration: 300.milliseconds, delay: 50.milliseconds),
                      itemBuilder: (_, index) {
                        return SelectCategoryItemComponent(
                          categoryData: list[index],
                        );
                      },
                    ),
                  ]);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Observer(
              builder: (_) => CommonBottomPriceWidget(
                title: bookingRequestStore.employeeName,
                subtitle: bookingRequestStore.selectedServiceList
                    .validate()
                    .map((e) => widget.isReschedule
                        ? e.serviceName.validate()
                        : e.name.validate())
                    .toList()
                    .join(', '),
                price: bookingRequestStore.totalAmount,
                buttonText: locale.next,
                onTap: () {
                  customStepperController.nextPage(
                      duration: 200.milliseconds, curve: Curves.easeOut);
                },
              ),
            ),
          ),
          Observer(
              builder: (context) =>
                  const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
