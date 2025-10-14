import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:grow_tokyo_app/services/local_notification_service.dart';

Future<PointData> getPointsAPI() async {
  var res = await handleResponse(
      await buildHttpResponse(APIEndPoints.credit, method: HttpMethodType.GET));
  final pointData = PointData.fromJson(res);

  final prevPoints = userStore.pointAmount;
  userStore.setPointAmount(pointData.amount);
  userStore.setConversionRates(pointData.conversionRates);

  // If points increased, show a local notification
  try {
    if (pointData.amount > prevPoints) {
      final gained = (pointData.amount - prevPoints);
      await LocalNotificationService.showNotification(
        title: 'Points updated',
        body: 'You earned +${gained.toStringAsFixed(0)} points! 🎉',
        payload: 'points_update',
      );
    }
  } catch (e) {
    log('⚠️ Failed to show points update notification: $e');
  }

  return pointData;
}

Future<List<PointTransactionData>> getPointsTransactionsAPI({
  int page = 1,
  int perPage = 10,
  String? tabParam,
  List<PointTransactionData> list = const [],
}) async {
  var res = PointTransactionsResponse.fromJson(await handleResponse(
      await buildHttpResponse(
          '${APIEndPoints.creditTransactions}?per_page=$perPage&page=$page&tab=$tabParam',
          method: HttpMethodType.GET)));
  if (page == 1) list.clear();
  list.addAll(res.transactions.validate());
  return list;
}
