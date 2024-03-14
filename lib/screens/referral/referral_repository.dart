import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/referral/model/referral_transactions_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:nb_utils/nb_utils.dart';

Future<String> getReferralCodeAPI() async {
  var res = await handleResponse(await buildHttpResponse(
      APIEndPoints.referralCode,
      method: HttpMethodType.GET));
  return res['referral_code'];
}

Future<List<ReferralTransactionData>> getReferralTransactionsAPI() async {
  var res = ReferralTransactionsResponse.fromJson(await handleResponse(
      await buildHttpResponse(APIEndPoints.referralTransactions,
          method: HttpMethodType.GET)));
  return res.data.validate();
}

Future<double> getRefferalCodeRewardPercentageAPI(String code) async {
  var res = await handleResponse(await buildHttpResponse(
      APIEndPoints.checkReferralCode,
      method: HttpMethodType.POST,
      request: {'referral_code': code}));
  return (res['data']['referral_reward_percent'] as num).toDouble();
}
