import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/coupon/model/coupon_list_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<List<CouponData>> getCouponList() async {
  final res = CouponListResponse.fromJson(await handleResponse(
      await buildHttpResponse(APIEndPoints.coupons,
          method: HttpMethodType.GET)));

  return res.couponList;
}
