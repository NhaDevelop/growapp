import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/screens/services/models/service_response.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceItemComponent extends StatelessWidget {
  const ServiceItemComponent({
    super.key,
    required this.service,
  });

  final ServiceListData service;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CachedImageWidget(
          url: service.serviceImage.validate(),
          height: 40,
          width: 40,
          fit: BoxFit.cover,
        ).cornerRadiusWithClipRRect(8),
        12.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (service.name ?? service.serviceName).validate(),
              style: boldTextStyle(),
            ),
            4.height,
            Text(service.description.validate(), style: secondaryTextStyle()),
          ],
        ).expand(),
      ],
    );
  }
}
