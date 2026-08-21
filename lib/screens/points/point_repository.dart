import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/services/local_notification_service.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<PointData> getPointsAPI({List<PointTransactionData>? transactions}) async {
  dynamic res;
  try {
    res = await handleResponse(
      await buildHttpResponse(APIEndPoints.pointsOverview, method: HttpMethodType.GET),
    );
  } catch (e) {
    log('⚠️ Primary overview API failed ($e), trying /overview fallback');
    try {
      res = await handleResponse(
        await buildHttpResponse('overview', method: HttpMethodType.GET),
      );
    } catch (e2) {
      log('⚠️ Secondary overview API failed ($e2), trying /credit fallback');
      res = await handleResponse(
        await buildHttpResponse(APIEndPoints.credit, method: HttpMethodType.GET),
      );
    }
  }

  final pointData = PointData.fromJson(res, transactions: transactions);

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
  dynamic res;
  final tabQuery = (tabParam != null && tabParam.isNotEmpty) ? '&tab=$tabParam&type=$tabParam' : '';
  final endpoint = '${APIEndPoints.pointsHistory}?per_page=$perPage&page=$page$tabQuery';
  try {
    res = await handleResponse(
      await buildHttpResponse(endpoint, method: HttpMethodType.GET),
    );
  } catch (e) {
    log('⚠️ Primary history API failed ($e), trying /history fallback');
    try {
      res = await handleResponse(
        await buildHttpResponse('history?per_page=$perPage&page=$page$tabQuery', method: HttpMethodType.GET),
      );
    } catch (e2) {
      log('⚠️ Secondary history API failed ($e2), trying /credit-transactions fallback');
      final fallbackEndpoint = '${APIEndPoints.creditTransactions}?per_page=$perPage&page=$page$tabQuery';
      res = await handleResponse(
        await buildHttpResponse(fallbackEndpoint, method: HttpMethodType.GET),
      );
    }
  }

  final responseObj = PointTransactionsResponse.fromJson(res);
  if (page == 1) list.clear();
  list.addAll(responseObj.transactions.validate());
  return list;
}
