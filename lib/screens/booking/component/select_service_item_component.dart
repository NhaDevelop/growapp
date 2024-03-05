import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectServiceItemComponent extends StatelessWidget {
  final ServiceListData service;
  final bool selected;
  final VoidCallback onChanged;
  const SelectServiceItemComponent(
      {super.key,
      required this.service,
      required this.selected,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onChanged,
      child: Row(
        children: [
          CachedImageWidget(
            url: service.serviceImage.validate(),
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ).cornerRadiusWithClipRRect(8),
          8.width,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name.validate(),
                style: boldTextStyle(),
              ),
              8.height,
              Text(
                service.description.validate(),
                style: secondaryTextStyle(),
              ),
            ],
          ).expand(),
          Checkbox(
            value: selected,
            onChanged: (_) => onChanged(),
          )
        ],
      ),
    );
  }
}
