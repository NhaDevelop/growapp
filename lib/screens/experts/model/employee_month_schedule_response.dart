class EmployeeMonthScheduleResponse {
  final List<EmployeeWorkingDayModel> employeeWorkingDaysList;

  EmployeeMonthScheduleResponse({required this.employeeWorkingDaysList});

  factory EmployeeMonthScheduleResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeMonthScheduleResponse(
      employeeWorkingDaysList: List<EmployeeWorkingDayModel>.from(
          (json['data'] as List)
              .map((x) => EmployeeWorkingDayModel.fromJson(x))),
    );
  }
}

class EmployeeWorkingDayModel {
  final String branchName;
  final DateTime date;

  EmployeeWorkingDayModel({required this.branchName, required this.date});

  factory EmployeeWorkingDayModel.fromJson(Map<String, dynamic> json) {
    return EmployeeWorkingDayModel(
      branchName: json['branch_name'],
      date: DateTime.parse(json['date']),
    );
  }
}
