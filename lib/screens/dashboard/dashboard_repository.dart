// import 'package:nb_utils/nb_utils.dart';

import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/cart/model/country_list_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';

import '../../main.dart';
import 'models/dashboard_model.dart';

Future<DashboardResponse> userDashboard({required int branchId}) async {
  String endPoint = '${APIEndPoints.dashboardDetail}?branch_id=$branchId';

  try {
    dashboardResponseCached = DashboardResponse.fromJson(
        await handleResponse(await buildHttpResponse(endPoint)));

    appStore.setLoading(false);

    return dashboardResponseCached!;
  } catch (e) {
    appStore.setLoading(false);
    rethrow;
  }
}

Future<List<CountryData>> getCountries() async {
  final json =
      await handleResponse(await buildHttpResponse(APIEndPoints.country));
  final list =
      (json['data'] as List).map((e) => CountryData.fromJson(e)).toList();

  return list;
}
