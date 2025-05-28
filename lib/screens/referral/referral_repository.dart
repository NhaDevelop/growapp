import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_data.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_transactions_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

Future<ReferralData> getReferralCodeAPI() async {
  var res = await handleResponse(await buildHttpResponse(
      APIEndPoints.referralCode,
      method: HttpMethodType.GET));

  final data = ReferralData.fromJson(res);
  referralDataCached = data;

  return data;
}

Future<List<ReferralTransactionData>> getReferralTransactionsAPI({
  int page = 1,
  int perPage = PER_PAGE_ITEM,
  List<ReferralTransactionData> list = const [],
}) async {
  var res = ReferralTransactionsResponse.fromJson(await handleResponse(
      await buildHttpResponse(
          '${APIEndPoints.referralTransactions}?per_page=$perPage&page=$page',
          method: HttpMethodType.GET)));
  if (page == 1) list.clear();
  list.addAll(res.data.validate());
  return list;
}

Future<double> getRefferalCodeRewardPercentageAPI(String code) async {
  var res = await handleResponse(await buildHttpResponse(
      APIEndPoints.checkReferralCode,
      method: HttpMethodType.POST,
      request: {'referral_code': code}));
  return (res['data']['referral_reward_percent'] as num).toDouble();
}
