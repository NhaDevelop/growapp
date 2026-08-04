import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/common_base.dart';
import 'package:grow_tokyo_app/utils/extensions/string_extensions.dart';
import 'package:grow_tokyo_app/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/default_user_image_placeholder.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../dashboard/component/booking_list_component.dart';
import '../booking_repository.dart';
import '../model/booking_list_response.dart';
import '../view/booking_detail_screen.dart';

class BookingItemComponent extends StatelessWidget {
  final BookingListData bookingData;

  const BookingItemComponent({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    final bookingStatusColor =
        getBookingStatusColor(status: bookingData.status.validate());
    
    print('Booking ${bookingData.id} employeeImage: ${bookingData.employeeImage}');

    return Container(
      width: context.width(),
      margin: const EdgeInsets.all(8),
      decoration:
          boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor:
                  bookingData.status == BookingStatusConst.COMPLETED
                      ? primaryColor
                      : territoryButtonColor,
              borderRadius: radiusOnly(topLeft: defaultRadius),
            ),
            child: Text(
              '#${bookingData.id.validate()}',
              style: boldTextStyle(
                  color: bookingData.status == BookingStatusConst.COMPLETED
                      ? Colors.white
                      : secondaryColor,
                  size: 12),
            ),
          ),
          12.height,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) {
                      String serviceImgUrl = '';
                      if (bookingData.serviceList.validate().isNotEmpty) {
                        final firstService = bookingData.serviceList!.first;
                        serviceImgUrl = firstService.serviceImage.validate();
                        final svcId = firstService.serviceId ?? firstService.id;
                        // Fix broken S3 URLs by extracting filename and mapping to CMS
                        if (serviceImgUrl.isNotEmpty && serviceImgUrl.contains('s3.ap-southeast-1.amazonaws.com')) {
                          final uri = Uri.tryParse(serviceImgUrl);
                          if (uri != null && uri.pathSegments.isNotEmpty) {
                            final filename = uri.pathSegments.last;
                            serviceImgUrl = 'https://cms.hairmake-grow.com/upload/services/$svcId/$filename';
                          }
                        }
                      }
                      return CachedImageWidget(
                        url: serviceImgUrl,
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                        radius: defaultRadius,
                      );
                    },
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Marquee(
                        directionMarguee: DirectionMarguee.oneDirection,
                        child: Text(bookingData.branchName.validate(),
                            style: boldTextStyle()),
                      ),
                      2.height,
                      if (bookingData.serviceList.validate().isNotEmpty)
                        Marquee(
                          directionMarguee: DirectionMarguee.oneDirection,
                          child: Text(
                            bookingData.serviceList
                                .validate()
                                .map((e) => e.serviceName.validate())
                                .toList()
                                .join(', '),
                            style: secondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      10.height,
                      Row(
                        children: [
                          Builder(
                            builder: (context) {
                              String imgUrl = bookingData.employeeImage ?? '';
                              // Fix broken S3 URLs or missing base URLs by mapping to the working CMS URL
                              if (imgUrl.isNotEmpty) {
                                if (imgUrl.contains('s3.ap-southeast-1.amazonaws.com')) {
                                  final uri = Uri.tryParse(imgUrl);
                                  if (uri != null && uri.pathSegments.isNotEmpty) {
                                    final filename = uri.pathSegments.last;
                                    if (bookingData.employeeId != null) {
                                      imgUrl = 'https://cms.hairmake-grow.com/upload/users/${bookingData.employeeId}/$filename';
                                    }
                                  }
                                } else if (!imgUrl.startsWith('http') && bookingData.employeeId != null) {
                                  imgUrl = 'https://cms.hairmake-grow.com/upload/users/${bookingData.employeeId}/$imgUrl';
                                }
                              }
                              
                              return CachedImageWidget(
                                url: imgUrl,
                                height: 20,
                                width: 20,
                                fit: BoxFit.cover,
                                circle: true,
                                child: const DefaultUserImagePlaceholder(size: 12),
                              ).paddingRight(4);
                            }
                          ),
                          if (bookingData.employeeName.validate().isNotEmpty)
                            Marquee(
                              child: Text(
                                bookingData.employeeName.validate(),
                                style: secondaryTextStyle(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ).paddingRight(16).expand(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ic_booking_status
                                  .iconImage(
                                      size: 16, color: bookingStatusColor)
                                  .paddingRight(8),
                              Text(
                                getBookingStatusKey(
                                    status: bookingData.status.validate()),
                                style: boldTextStyle(
                                    size: 13, color: bookingStatusColor),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ).expand(),
                ],
              ).paddingSymmetric(horizontal: 16),
              Column(
                children: [
                  Divider(color: context.dividerColor),
                  6.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ic_selected_booking.iconImage(
                              size: 12, color: primaryColor),
                          8.width,
                          Text(bookingData.bookingDate.validate(),
                              style: primaryTextStyle(), maxLines: 1),
                        ],
                      ),
                      Row(
                        children: [
                          ic_clock.iconImage(size: 14, color: primaryColor),
                          8.width,
                          Text(bookingData.bookingTime.validate(),
                              style: primaryTextStyle(), maxLines: 1),
                        ],
                      ),
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 8),
              // if (bookingData.status == BookingStatusConst.COMPLETED)
              //   Column(
              //     children: [
              //       8.height,
              //       AppButton(
              //         text: locale.reschedule,
              //         padding: const EdgeInsets.symmetric(vertical: 12),
              //         width: context.width(),
              //         textColor: secondaryColor,
              //         color: territoryButtonColor,
              //         elevation: 0,
              //         onTap: () {
              //           BookingScreen(
              //                   services: bookingData.serviceList.validate(),
              //                   isReschedule: true)
              //               .launch(context);
              //         },
              //       ).paddingSymmetric(horizontal: 16),
              //       8.height,
              //     ],
              //   ),
              if ((bookingData.status == BookingStatusConst.PENDING || bookingData.status == BookingStatusConst.CONFIRMED) &&
                  (bookingData.payment == null ||
                      (bookingData.payment != null &&
                          bookingData.payment!.paymentStatus != 1)))
                AppButton(
                  text: locale.cancelAppointment,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: context.width(),
                  textColor: secondaryColor,
                  color: quaternaryButtonColor,
                  elevation: 0,
                  onTap: () {
                    showConfirmDialogCustom(
                      context,
                      title: locale.doYouWantToCancelBooking,
                      primaryColor: context.primaryColor,
                      positiveText: locale.yes,
                      negativeText: locale.no,
                      onAccept: (_) {
                        Map req = {
                          'id': bookingData.id,
                          'status': BookingStatusConst.CANCELLED,
                        };

                        appStore.setLoading(true);

                        bookingUpdate(req).then((value) {
                          onBookingListUpdate.call('');
                          appStore.setLoading(false);
                          toast(locale.bookingSuccessfullyUpdateMessage);
                        }).catchError((e) {
                          appStore.setLoading(false);
                          toast(e.toString());
                        });
                      },
                    );
                  },
                ).paddingSymmetric(horizontal: 16, vertical: 8)
              else
                const Offstage(),
              8.height,
            ],
          ),
        ],
      ).onTap(() {
        hideKeyboard(context);
        BookingDetailScreen(
                bookingId: bookingData.id.validate(),
                bookingStatus: bookingData.status.validate())
            .launch(context);
      }, borderRadius: radius()),
    );
  }
}
