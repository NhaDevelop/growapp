import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:grow_tokyo_app/components/app_scaffold.dart';
import 'package:grow_tokyo_app/components/bottom_sheet_button.dart';
import 'package:grow_tokyo_app/components/custom_stepper.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_group_component.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_list_component_new.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
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
  late String groupId = bookingRequestStore.employeeGroupId;

  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    future = getEmployeeList(
        branchId: appStore.branchId,
        page: page,
        list: expertList,
        lastPageCallBack: (p0) {
          isLastPage = p0;
        });
  }

  void onNextClick() {
    if (employeeId != UNSELECTED_EMPLOYEE_ID) {
      Fluttertoast.cancel();
      bookingRequestStore.setEmployeeIdInRequest(employeeId.validate());

      final employeeName = expertList
          .firstWhere((element) => element.id == employeeId)
          .fullName
          .validate();
      bookingRequestStore.setEmployeeNameInRequest(employeeName);

      customStepperController.nextPage(
          duration: 200.milliseconds, curve: Curves.easeOut);
    } else if (groupId != UNSELECTED_EMPLOYEE_GROUP_ID) {
      Fluttertoast.cancel();
      bookingRequestStore.setEmployeeGroupIdInRequest(groupId);
      final groupName = employeeGroups()
          .firstWhere((element) => element.nationality == groupId)
          .name
          .validate();
      bookingRequestStore.setEmployeeNameInRequest(groupName);

      customStepperController.nextPage(
          duration: 200.milliseconds, curve: Curves.easeOut);
    } else {
      toast(locale.pleaseChooseYourStylist);
    }
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
          Stack(
            fit: StackFit.expand,
            children: [
              SnapHelperWidget<List<EmployeeData>>(
                future: future,
                initialData: branchEmployeeListCached?[appStore.branchId],
                loadingWidget: const BookingStep1Shimmer(),
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
                  return AnimatedScrollView(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 70, bottom: 16),
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
                              groupId = UNSELECTED_EMPLOYEE_GROUP_ID;
                              setState(() {});
                            },
                            child: EmployeeListComponentNew(
                              expertData: data,
                              selected: employeeId == data.id,
                            ),
                          );
                        },
                      ),
                      ...employeeGroups().map(
                        (e) => EmployeeGroupComponent(
                          data: e,
                          selected: e.nationality == groupId,
                          onTap: () {
                            groupId = e.nationality;
                            employeeId = UNSELECTED_EMPLOYEE_ID;
                            setState(() {});
                          },
                        ).paddingTop(16),
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
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomSheetButton(
                  text: locale.next,
                  onTap: onNextClick,
                ),
              ),
            ],
          ),
          Observer(
              builder: (context) =>
                  const LoaderWidget().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
