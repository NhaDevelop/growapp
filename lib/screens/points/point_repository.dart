import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/points/model/point_data.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:grow_tokyo_app/services/local_notification_service.dart';

Future<PointData> getPointsAPI({
  List<PointTransactionData> transactions = const [],
}) async {
  Map<String, dynamic>? res;

  // Try primary Overview API endpoint
  try {
    res = await handleResponse(
      await buildHttpResponse(
        APIEndPoints.pointsOverview,
        method: HttpMethodType.GET,
      ),
    );
  } catch (e) {
    log('⚠️ Primary pointsOverview endpoint failed: $e. Trying fallbacks...');
  }

  // Fallback 1: 'overview'
  if (res == null || res['status'] == false) {
    try {
      res = await handleResponse(
        await buildHttpResponse('overview', method: HttpMethodType.GET),
      );
    } catch (e) {
      log('⚠️ Fallback overview endpoint failed: $e');
    }
  }

  // Fallback 2: Legacy 'credit'
  if (res == null || res['status'] == false) {
    try {
      res = await handleResponse(
        await buildHttpResponse(APIEndPoints.credit, method: HttpMethodType.GET),
      );
    } catch (e) {
      log('⚠️ Legacy credit endpoint failed: $e');
    }
  }

  final pointData = PointData.fromJson(res ?? {}, historyList: transactions);

  final prevPoints = userStore.pointAmount;
  userStore.setPointAmount(pointData.amount);
  userStore.setConversionRates(pointData.conversionRates);

  // If points increased, show local notification
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
    log('⚠️ Failed to show points notification: $e');
  }

  return pointData;
}

Future<List<PointTransactionData>> getPointsTransactionsAPI({
  int page = 1,
  int perPage = 15,
  String? tabParam,
  List<PointTransactionData> list = const [],
}) async {
  Map<String, dynamic>? resMap;

  // Try primary History API endpoint
  try {
    resMap = await handleResponse(
      await buildHttpResponse(
        '${APIEndPoints.pointsHistory}?per_page=$perPage&page=$page${tabParam != null ? '&tab=$tabParam' : ''}',
        method: HttpMethodType.GET,
      ),
    );
  } catch (e) {
    log('⚠️ Primary pointsHistory endpoint failed: $e. Trying fallbacks...');
  }

  // Fallback 1: 'history'
  if (resMap == null || resMap['status'] == false) {
    try {
      resMap = await handleResponse(
        await buildHttpResponse(
          'history?per_page=$perPage&page=$page${tabParam != null ? '&tab=$tabParam' : ''}',
          method: HttpMethodType.GET,
        ),
      );
    } catch (e) {
      log('⚠️ Fallback history endpoint failed: $e');
    }
  }

  // Fallback 2: Legacy 'credit-transactions'
  if (resMap == null || resMap['status'] == false) {
    try {
      resMap = await handleResponse(
        await buildHttpResponse(
          '${APIEndPoints.creditTransactions}?per_page=$perPage&page=$page${tabParam != null ? '&tab=$tabParam' : ''}',
          method: HttpMethodType.GET,
        ),
      );
    } catch (e) {
      log('⚠️ Legacy creditTransactions endpoint failed: $e');
    }
  }

  final res = PointTransactionsResponse.fromJson(resMap ?? {});
  if (page == 1) list.clear();
  list.addAll(res.transactions.validate());
  return list;
}
