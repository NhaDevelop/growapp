import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/custom_stepper.dart';
import 'package:grow_tokyo_app/screens/booking/component/booking_step1_component.dart';
import 'package:grow_tokyo_app/screens/booking/component/booking_step2_component.dart';
import 'package:grow_tokyo_app/store/booking_request_store.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../services/models/service_response.dart';
import '../component/booking_step3_component.dart';

class CustomStep {
  final String? title;
  final Widget? page;

  CustomStep({this.title, this.page});
}

class BookingScreen extends StatefulWidget {
  final List<ServiceListData> services;
  final bool isReschedule;

  const BookingScreen(
      {super.key, required this.services, this.isReschedule = false});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<CustomStep>? stepsList;
  final currentStep = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    init();

    bookingRequestStore = BookingRequestStore();

    bookingRequestStore.setSelectedServiceListInRequest(widget.services,
        isRescheduleInRequest: widget.isReschedule);
    if (branchConfigurationCached != null) {
      bookingRequestStore
          .setTaxPercentageInRequest(branchConfigurationCached!.tax.validate());
    }
  }

  void init() async {
    stepsList = [
      CustomStep(
          title: locale.staff,
          page: BookingStep1Component(isReschedule: widget.isReschedule)),
      CustomStep(
          title: locale.services,
          page: BookingStep2Component(isReschedule: widget.isReschedule)),
      CustomStep(
          title: '${locale.date} & ${locale.time}',
          page: BookingStep3Component(isReschedule: widget.isReschedule)),
    ];
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
    return ValueListenableBuilder<int>(
      valueListenable: currentStep,
      builder: (context, step, child) {
        return PopScope(
          canPop: step == 0,
          onPopInvoked: (canPop) {
            if (canPop) return;
            bookingRequestStore.time = '';
            customStepperController.previousPage(
                duration: 300.milliseconds, curve: Curves.linear);
            LiveStream().emit(LiveStreamKeyConst.LIVESTREAM_CHANGE_STEP, step);
          },
          child: child ?? const SizedBox(),
        );
      },
      child: Scaffold(
        body: CustomStepper(
          stepsList: stepsList.validate(),
          onChange: (p0) => currentStep.value = p0,
        ),
      ),
    );
  }
}
