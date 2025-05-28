import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/screens/booking/component/select_service_item_component.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_service_list_response.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class CategoryItemComponent extends StatefulWidget {
  final EmployeeServiceListData data;
  final List<ServiceListData> selectedServices;
  final void Function(ServiceListData) onServiceSelect;

  const CategoryItemComponent(
      {super.key,
      required this.data,
      required this.selectedServices,
      required this.onServiceSelect});

  @override
  State<CategoryItemComponent> createState() => _CategoryItemComponentState();
}

class _CategoryItemComponentState extends State<CategoryItemComponent> {
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _setInitialExpand();
  }

  void _setInitialExpand() {
    final isAnyServiceSelected = widget.data.services.any(
        (e) => widget.selectedServices.any((element) => element.id == e.id));

    isExpanded = isAnyServiceSelected;
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
      onTap: () => setState(() => isExpanded = !isExpanded),
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
                    widget.data.category.name.validate(),
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
                ? AnimatedWrap(
                    runSpacing: 16,
                    itemCount: widget.data.services.length,
                    itemBuilder: (context, index) {
                      final service = widget.data.services[index];
                      return SelectServiceItemComponent(
                        service: service,
                        selected: widget.selectedServices
                            .any((e) => e.id == service.id),
                        onChanged: () => widget.onServiceSelect(service),
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
