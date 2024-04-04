import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/network/network_utils.dart';
import 'package:grow_tokyo_app/screens/profile/model/pages_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';

Future<List<PageModel>> getPages() async {
  final res = PagesResponse.fromJson(
      await handleResponse(await buildHttpResponse(APIEndPoints.pages)));
  pageListCached = res.pages;

  return res.pages;
}
