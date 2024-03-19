import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/common_bottom_price_widget.dart';
import 'package:grow_tokyo_app/components/custom_stepper.dart';
import 'package:grow_tokyo_app/screens/booking/shimmer/booking_step2_shimmer.dart';
import 'package:grow_tokyo_app/screens/booking/component/category_item_component.dart';
import 'package:grow_tokyo_app/screens/experts/employee_repository.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_service_list_response.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
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
  Future<List<EmployeeServiceListData>>? future;
  late List<ServiceListData> selectedServices = [
    ...bookingRequestStore.selectedServiceList
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getEmployeeServiceList(employeeId: bookingRequestStore.employeeId);
  }

  void _onServiceSelect(ServiceListData service) {
    if (selectedServices.any((e) => e.id == service.id)) {
      selectedServices.removeWhere((element) => element.id == service.id);
    } else {
      selectedServices.add(service);
    }
    setState(() {});
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
          SnapHelperWidget(
            future: future,
            initialData: categoryListCached,
            loadingWidget: const BookingStep2Shimmer(),
            onSuccess: (list) {
              if (list.isEmpty) {
                return NoDataWidget(
                  title: locale.noCategoryFound,
                  retryText: locale.reload,
                  onRetry: () {
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
                    init();
                    setState(() {});
                  },
                  children: [
                    Center(
                      child: Text(
                        '${bookingRequestStore.employeeName}\'s ${locale.services}',
                        style: primaryTextStyle(weight: FontWeight.w500),
                      ),
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
                        return CategoryItemComponent(
                          data: list[index],
                          selectedServices: selectedServices,
                          onServiceSelect: _onServiceSelect,
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
                buttonText: locale.next,
                onTap: () {
                  if (selectedServices.isEmpty) {
                    toast(locale.pleaseSelectService);
                    return;
                  }
                  bookingRequestStore
                      .setSelectedServiceListInRequest(selectedServices);
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
