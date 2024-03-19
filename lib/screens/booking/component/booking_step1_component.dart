import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/common_bottom_price_widget.dart';
import 'package:grow_tokyo_app/components/custom_stepper.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_list_component_new.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/empty_error_state_widget.dart';
import '../../../components/loader_widget.dart';
import '../../../main.dart';
import '../../experts/employee_repository.dart';
import '../../experts/model/employee_detail_response.dart';
import '../shimmer/booking_step1_shimmer.dart';

class BookingStep1Component extends StatefulWidget {
  final bool isReschedule;

  const BookingStep1Component({super.key, this.isReschedule = false});

  @override
  State<BookingStep1Component> createState() => _BookingStep1ComponentState();
}

class _BookingStep1ComponentState extends State<BookingStep1Component> {
  Future<List<EmployeeData>>? future;

  List<EmployeeData> expertList = [];

  int page = 1;
  late int employeeId = bookingRequestStore.employeeId;

  String serviceIds = '';

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.isReschedule) {
      serviceIds = bookingRequestStore.selectedServiceList
          .validate()
          .map((e) => e.serviceId.validate())
          .toList()
          .join(',');
    } else {
      serviceIds = bookingRequestStore.selectedServiceList
          .validate()
          .map((e) => e.id.validate())
          .toList()
          .join(',');
    }

    future = getEmployeeList(
        branchId: appStore.branchId,
        serviceIds: serviceIds,
        page: page,
        list: expertList,
        lastPageCallBack: (p0) {
          isLastPage = p0;
        });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showAppBar: false,
      body: Stack(
        children: [
          SnapHelperWidget<List<EmployeeData>>(
            future: future,
            initialData: employeeListCached,
            loadingWidget: const BookingStep1Shimmer(),
            onSuccess: (list) {
              if (list.isEmpty) {
                return NoDataWidget(
                  title: locale.noStaffFound,
                  imageWidget: const EmptyStateWidget(),
                  subTitle:
                      '${locale.noStaffAvailableForBranchMessage}\n${locale.tryToChangeYourService}',
                  retryText: locale.goBack,
                  onRetry: () {
                    finish(context);
                  },
                );
              }

              return Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScrollView(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 70, bottom: 100),
                    physics: const AlwaysScrollableScrollPhysics(),
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        locale.chooseYourStylist,
                        style: primaryTextStyle(weight: FontWeight.w500),
                      ),
                      16.height,
                      AnimatedWrap(
                        runSpacing: 16,
                        spacing: 16,
                        columnCount: 1,
                        itemCount: list.length,
                        listAnimationType: ListAnimationType.Scale,
                        scaleConfiguration: ScaleConfiguration(
                            duration: 300.milliseconds, delay: 50.milliseconds),
                        itemBuilder: (_, i) {
                          EmployeeData data = list[i];

                          return GestureDetector(
                            onTap: () {
                              employeeId = data.id.validate();
                              setState(() {});
                            },
                            child: EmployeeListComponentNew(
                              expertData: data,
                              selected: employeeId == data.id,
                            ),
                          );
                        },
                      ),
                    ],
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
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Observer(
                      builder: (_) => CommonBottomPriceWidget(
                        title: bookingRequestStore.employeeName,
                        subtitle: bookingRequestStore.selectedServiceList
                            .map((e) => widget.isReschedule
                                ? e.serviceName.validate()
                                : e.name.validate())
                            .toList()
                            .join(', '),
                        buttonText: locale.next,
                        onTap: () {
                          if (employeeId != UNSELECTED_EMPLOYEE_ID) {
                            Fluttertoast.cancel();
                            bookingRequestStore
                                .setEmployeeIdInRequest(employeeId.validate());

                            final employeeName = list
                                .firstWhere(
                                    (element) => element.id == employeeId)
                                .fullName
                                .validate();
                            bookingRequestStore
                                .setEmployeeNameInRequest(employeeName);

                            customStepperController.nextPage(
                                duration: 200.milliseconds,
                                curve: Curves.easeOut);
                          } else {
                            toast(locale.pleaseChooseYourStylist);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  page = 1;
                  appStore.setLoading(true);

                  init();
                  setState(() {});
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
