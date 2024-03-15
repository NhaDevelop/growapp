import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/points/model/point_transactions_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<double> getPointsAPI() async {
  var res = await handleResponse(
      await buildHttpResponse(APIEndPoints.credit, method: HttpMethodType.GET));
  return res['credit'];
}

Future<List<PointTransactionData>> getPointsTransactionsAPI({
  int page = 1,
  int perPage = 10,
  String tabParam = '',
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
