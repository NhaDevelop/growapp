import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_calendar_component.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../experts/model/employee_detail_response.dart';

class EmployeeListComponentNew extends StatefulWidget {
  final EmployeeData expertData;
  final bool selected;

  const EmployeeListComponentNew({
    super.key,
    required this.expertData,
    required this.selected,
  });

  @override
  State<EmployeeListComponentNew> createState() =>
      _EmployeeListComponentNewState();
}

class _EmployeeListComponentNewState extends State<EmployeeListComponentNew> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(12),
        backgroundColor: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CachedImageWidget(
                url: widget.expertData.profileImage.validate(),
                height: 58,
                width: 58,
                circle: true,
                fit: BoxFit.cover,
                child: const DefaultUserImagePlaceholder(),
              ),
              16.width,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.expertData.fullName.validate(),
                    style: boldTextStyle(size: 14),
                  ),
                  if (widget.expertData.expert.validate().isNotEmpty) ...[
                    4.height,
                    Text(widget.expertData.expert.validate(),
                        style: secondaryTextStyle()),
                  ],
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() => _expanded = !_expanded),
                    child: Text(
                      locale.viewSchedule,
                      style: secondaryTextStyle(
                          decoration: TextDecoration.underline),
                    ).paddingOnly(top: 4, bottom: 4, right: 8),
                  ),
                ],
              ).expand(),
              SizedBox(
                width: 21,
                height: 21,
                child: Icon(
                  widget.selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                ),
              )
            ],
          ).paddingAll(16),
          AnimatedSize(
            duration: defaultAnimationDuration,
            child: _expanded
                ? EmployeeCalendarComponent(
                    employeeId: widget.expertData.id.validate(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
