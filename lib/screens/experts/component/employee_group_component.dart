import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_group_model.dart';
import 'package:nb_utils/nb_utils.dart';

class EmployeeGroupComponent extends StatelessWidget {
  final EmployeeGroupModel data;
  final bool selected;
  final VoidCallback onTap;

  const EmployeeGroupComponent({
    super.key,
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
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
                Container(
                  decoration: boxDecorationDefault(
                    shape: BoxShape.circle,
                    color: white,
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: CachedImageWidget(
                    url: data.profileImage.validate(),
                    height: 33,
                    width: 33,
                    circle: true,
                    fit: BoxFit.cover,
                    child: const DefaultUserImagePlaceholder(),
                  ).paddingAll(12),
                ),
                16.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name.validate(),
                      style: boldTextStyle(size: 14),
                    ),
                    if (data.description.validate().isNotEmpty) ...[
                      4.height,
                      Text(data.description.validate(),
                          style: secondaryTextStyle()),
                    ],
                  ],
                ).expand(),
                16.width,
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
          ],
        ),
      ),
    );
  }
}
