import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../experts/model/employee_detail_response.dart';

class EmployeeListComponentNew extends StatelessWidget {
  final EmployeeData expertData;
  final bool selected;

  const EmployeeListComponentNew({
    super.key,
    required this.expertData,
    required this.selected,
  });

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
      child: Row(
        children: [
          CachedImageWidget(
            url: expertData.profileImage.validate(),
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
                expertData.fullName.validate(),
                style: boldTextStyle(size: 14),
              ),
              // 4.height,
              // Text(expertData.expert.validate(), style: secondaryTextStyle()),
              4.height,
              Text(
                locale.viewSchedule,
                style: secondaryTextStyle(decoration: TextDecoration.underline),
              ),
            ],
          ).expand(),
          SizedBox(
            width: 21,
            height: 21,
            child: Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
            ),
          )
        ],
      ).paddingAll(16),
    );
  }
}
