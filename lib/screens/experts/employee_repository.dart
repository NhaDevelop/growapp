import 'package:grow_tokyo_app/screens/experts/model/employee_detail_response.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_month_schedule_response.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_response.dart';
import 'package:grow_tokyo_app/screens/experts/model/employee_service_list_response.dart';
import 'package:grow_tokyo_app/utils/api_end_points.dart';
import 'package:grow_tokyo_app/utils/extensions/list_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../../network/network_utils.dart';
import '../../utils/constants.dart';

Future<List<EmployeeData>> getEmployeeList({
  int? branchId,
  String serviceIds = '',
  String orderBy = '',
  int page = 1,
  var perPage = PER_PAGE_ITEM,
  required List<EmployeeData> list,
  Function(bool)? lastPageCallBack,
}) async {
  try {
    String order = orderBy.isNotEmpty ? '&order_by=$orderBy' : '';
    String services = serviceIds.isNotEmpty ? '&service_ids=$serviceIds' : '';

    EmployeeResponse res = EmployeeResponse.fromJson(await handleResponse(await buildHttpResponse(
      '${APIEndPoints.employeeList}?branch_id=$branchId$order$services&per_page=$perPage&page=$page',
      method: HttpMethodType.GET,
    )));

    if (page == 1) list.clear();
    list.addAll(res.topExperts.validate());
    final anyJapanese = list.firstWhereOrNull(
      (element) => element.id == 104,
    );
    final anyCambodian = list.firstWhereOrNull((element) => element.id == 105);
    final anyVietnamese = list.firstWhereOrNull((element) => element.id == 106);
    list.removeWhere((element) => element.id == 104 || element.id == 105 || element.id == 106);
    if (anyJapanese != null) list.add(anyJapanese);
    if (anyCambodian != null) list.add(anyCambodian);
    if (anyVietnamese != null) list.add(anyVietnamese);
    employeeListCached = list;
    if (branchId != null) {
      branchEmployeeListCached = {...?branchEmployeeListCached, branchId: list};
    }

    lastPageCallBack?.call(res.topExperts.validate().length != perPage);

    appStore.setLoading(false);
  } catch (e) {
    appStore.setLoading(false);
    rethrow;
  }
  return list;
}

Future<EmployeeDetailResponse> getEmployeeDetail(
    {required int branchId, required int employeeId}) async {
  try {
    var res = EmployeeDetailResponse.fromJson(await handleResponse(await buildHttpResponse(
        '${APIEndPoints.employeeDetail}?branch_id=$branchId&employee_id=$employeeId',
        method: HttpMethodType.GET)));

    if (!employeeDetailCachedData.any((element) => element?.$1 == employeeId)) {
      employeeDetailCachedData.add((employeeId, res));
    } else {
      int index = employeeDetailCachedData.indexWhere((element) => element?.$1 == employeeId);
      employeeDetailCachedData[index] = (employeeId, res);
    }

    appStore.setLoading(false);

    return res;
  } catch (e) {
    appStore.setLoading(false);
    rethrow;
  }
}

Future<List<EmployeeWorkingDayModel>> getEmployeeMonthSchedule(
    {required int employeeId,
    required int branchId,
    Function(List<EmployeeWorkingDayModel>)? callback}) async {
  try {
    String url = '${APIEndPoints.employeeSchedule}?branch_id=$branchId';
    if (employeeId != UNSELECTED_EMPLOYEE_ID) {
      url = '$url&employee_id=$employeeId';
    }
    var res = EmployeeMonthScheduleResponse.fromJson(
        await handleResponse(await buildHttpResponse(url, method: HttpMethodType.GET)));

    employeeWorkingDayListCached = {
      ...?employeeWorkingDayListCached,
      if (employeeId != UNSELECTED_EMPLOYEE_ID) employeeId: res.employeeWorkingDaysList
    };
    callback?.call(res.employeeWorkingDaysList);
    appStore.setLoading(false);

    return res.employeeWorkingDaysList;
  } catch (e) {
    appStore.setLoading(false);
    rethrow;
  }
}

Future<List<EmployeeServiceListData>> getEmployeeServiceList(
    {required int employeeId,
    required int branchId,
    required Function(List<EmployeeServiceListData>) onLoaded}) async {
  String url = '${APIEndPoints.employeeServiceList}?branch_id=$branchId';
  if (bookingRequestStore.isEmployeeSelected) {
    url = '$url&employee_id=$employeeId';
  }
  final res = EmployeeServiceListResponse.fromJson(await handleResponse(
    await buildHttpResponse(url, method: HttpMethodType.GET),
  ));
  employeeServiceListCached = {...?employeeServiceListCached, employeeId: res.data};
  onLoaded(res.data);

  return res.data;
}
