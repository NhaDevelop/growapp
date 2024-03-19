import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/empty_error_state_widget.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/booking/component/select_service_item_component.dart';
import 'package:grow_tokyo_app/screens/booking/shimmer/service_list_shimmer.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/screens/services/service_repository.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../category/model/category_response.dart';

class CategoryItemComponent extends StatefulWidget {
  final CategoryData categoryData;
  final void Function(ServiceListData) onServiceSelect;

  const CategoryItemComponent(
      {super.key, required this.categoryData, required this.onServiceSelect});

  @override
  State<CategoryItemComponent> createState() => _CategoryItemComponentState();
}

class _CategoryItemComponentState extends State<CategoryItemComponent> {
  bool isExpanded = false;

  Future<List<ServiceListData>>? future;

  List<ServiceListData> serviceList = [];

  int page = 1;

  bool isLastPage = false;

  List<ServiceListData> selectedService = [];

  @override
  void initState() {
    super.initState();
  }

  void fetchServices() async {
    future = getServiceList(
      branchId: appStore.branchId,
      categoryId: widget.categoryData.id.validate().toString(),
      subCategoryId: '',
      page: page,
      search: '',
      list: serviceList,
      lastPageCallBack: (p0) {
        isLastPage = p0;
      },
    );
  }

  void serviceSelectOnChange(ServiceListData service) {
    if (selectedService.any((e) => e.id == service.id)) {
      selectedService.removeWhere((element) => element.id == service.id);
    } else {
      selectedService.add(service);
    }
    widget.onServiceSelect(service);

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
    return GestureDetector(
      onTap: () {
        isExpanded = !isExpanded;

        if (isExpanded) fetchServices();

        setState(() {});
      },
      child: Container(
        padding: EdgeInsets.zero,
        decoration:
            boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
        child: Column(
          children: [
            Row(
              children: [
                Marquee(
                  directionMarguee: DirectionMarguee.oneDirection,
                  child: Text(
                    widget.categoryData.name.validate(),
                    style: boldTextStyle(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ).paddingSymmetric(vertical: 8, horizontal: 8).expand(),
                Image.asset(
                  isExpanded ? chevron_up : chevron_down,
                  height: 20,
                  width: 20,
                  color: context.iconColor,
                ),
              ],
            ),
            isExpanded
                ? SnapHelperWidget(
                    future: future,
                    loadingWidget: const ServiceListShimmer(),
                    errorBuilder: (error) {
                      return NoDataWidget(
                        title: error,
                        retryText: locale.reload,
                        imageWidget: const ErrorStateWidget(),
                        onRetry: () {
                          page = 1;
                          appStore.setLoading(true);

                          fetchServices();
                        },
                      ).center();
                    },
                    onSuccess: (list) {
                      if (list.isEmpty) {
                        return NoDataWidget(
                          title: locale.noServicesFound,
                          imageWidget: const EmptyStateWidget(),
                        ).center();
                      }

                      return AnimatedWrap(
                        runSpacing: 16,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          final service = list[index];
                          return SelectServiceItemComponent(
                            service: service,
                            selected:
                                selectedService.any((e) => e.id == service.id),
                            onChanged: () => serviceSelectOnChange(service),
                          );
                        },
                      );
                    },
                  ).paddingOnly(top: 8)
                : const Offstage(),
          ],
        ).paddingAll(16),
      ),
    );
  }
}
