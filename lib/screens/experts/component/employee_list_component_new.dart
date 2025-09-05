import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grow_tokyo_app/components/cached_image_widget.dart';
import 'package:grow_tokyo_app/components/default_user_image_placeholder.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/experts/component/employee_calendar_component.dart';
import 'package:http/http.dart' as http;
import 'package:nb_utils/nb_utils.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../experts/model/employee_detail_response.dart';

class EmployeeListComponentNew extends StatefulWidget {
  final EmployeeData expertData;
  final bool selected;

  const EmployeeListComponentNew({
    super.key,
    required this.expertData,
    required this.selected,
  });

  @override
  State<EmployeeListComponentNew> createState() => _EmployeeListComponentNewState();
}

class _EmployeeListComponentNewState extends State<EmployeeListComponentNew> {
  final bool _expanded = false;
  int? _viewScheduleStatus;

  @override
  void initState() {
    super.initState();
    _loadViewScheduleStatus();
  }

  // Load status directly from API
  Future<void> _loadViewScheduleStatus() async {
    final employeeId = widget.expertData.id;
    if (employeeId == null) {
      setState(() {
        _viewScheduleStatus = 0;
      });
      return;
    }

    try {
      final response = await http.get(Uri.parse('https://cms.hairmake-grow.com/api/view-schedule-status'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        // Find this employee's status
        for (var item in data) {
          if (item['id'] == employeeId && item['view_schedule_status'] != null) {
            setState(() {
              _viewScheduleStatus = item['view_schedule_status'];
            });
            return;
          }
        }

        // Employee not found in response
        setState(() {
          _viewScheduleStatus = 0;
        });
      } else {
        print('Failed to load schedule status: ${response.statusCode}');
        setState(() {
          _viewScheduleStatus = 0;
        });
      }
    } catch (e) {
      print('Error loading schedule status: $e');
      setState(() {
        _viewScheduleStatus = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationWithRoundedCorners(
        borderRadius: radius(12),
        backgroundColor: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Show skeleton while loading status
          _viewScheduleStatus == null
              ? _buildStaffCardSkeleton()
              : _buildStaffCard(),
          AnimatedSize(
            duration: defaultAnimationDuration,
            child: _expanded
                ? EmployeeCalendarComponent(
              employeeId: widget.expertData.id.validate(),
              branchId: appStore.branchId,
              disableOtherBranchsDate: true,
            )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  // Build the actual staff card
  Widget _buildStaffCard() {
    return Row(
      children: [
        CachedImageWidget(
          url: widget.expertData.profileImage.validate(),
          height: 58,
          width: 58,
          circle: true,
          fit: BoxFit.cover,
          child: const DefaultUserImagePlaceholder(),
        ),
        16.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.expertData.fullName.validate(),
              style: boldTextStyle(size: 14),
            ),
            if (widget.expertData.description.validate().isNotEmpty) ...[
              4.height,
              Text(widget.expertData.description.validate(), style: secondaryTextStyle()),
            ],
            // Show View Schedule button only if view_schedule_status != 0
            if (_viewScheduleStatus != null && _viewScheduleStatus != 0) ...[
              8.height,
              AppButton(
                text: 'View Schedule',
                shapeBorder: RoundedRectangleBorder(borderRadius: radius(8)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                onTap: () => showScheduleDialog(context),
              ),
            ],
          ],
        ).expand(),
        16.width,
        SizedBox(
          width: 21,
          height: 21,
          child: Icon(
            widget.selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          ),
        )
      ],
    ).paddingAll(16);
  }

  // Build skeleton while loading
  Widget _buildStaffCardSkeleton() {
    return Row(
      children: [
        CachedImageWidget(
          url: widget.expertData.profileImage.validate(),
          height: 58,
          width: 58,
          circle: true,
          fit: BoxFit.cover,
          child: const DefaultUserImagePlaceholder(),
        ),
        16.width,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.expertData.fullName.validate(),
              style: boldTextStyle(size: 14),
            ),
            if (widget.expertData.description.validate().isNotEmpty) ...[
              4.height,
              Text(widget.expertData.description.validate(), style: secondaryTextStyle()),
            ],
            // Show skeleton button while loading view_schedule_status
            8.height,
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 32,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ).expand(),
        16.width,
        SizedBox(
          width: 21,
          height: 21,
          child: Icon(
            widget.selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          ),
        )
      ],
    ).paddingAll(16);
  }

  void showScheduleDialog(BuildContext context) async {
    if (_viewScheduleStatus == null || _viewScheduleStatus == 0) {
      toast("Schedule view not available.");
      return;
    }

    final employeeId = widget.expertData.id;
    if (employeeId == null) {
      toast("Invalid employee ID.");
      return;
    }

    // Show shimmer loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => buildCalendarShimmerPlaceholder(context),
    );

    try {
      String apiUrl;

      if (_viewScheduleStatus == 1) {
        // Use new API format
        apiUrl = 'https://hairmake-grow.com/web-booking/?page=api_date&method=view&branch_id=${appStore.branchId}&staff_id=$employeeId&debug=0';
      } else if (_viewScheduleStatus == 2) {
        // Use original API format
        apiUrl = 'https://cms.hairmake-grow.com/api/calendar-data';
      } else {
        Navigator.pop(context);
        toast("Invalid schedule configuration.");
        return;
      }

      final res = await http.get(Uri.parse(apiUrl));
      Navigator.pop(context); // Close shimmer

      if (res.statusCode != 200) {
        toast("Failed to load schedule.");
        return;
      }

      final data = json.decode(res.body);

      // Handle response based on API type
      if (_viewScheduleStatus == 1) {
        await _handleNewApiResponse(context, data);
      } else if (_viewScheduleStatus == 2) {
        await _handleOriginalApiResponse(context, data);
      }
    } catch (e) {
      Navigator.pop(context);
      toast("Error loading schedule: ${e.toString()}");
    }
  }

  // Handle new API response format (status = 1)
  Future<void> _handleNewApiResponse(BuildContext context, Map<String, dynamic> data) async {
    print('New API Response:');
    print(data);

    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

    Map<int, String?> dayMap = {};

    // Parse the date-based response format
    // Example: {"2025-08-29":1,"2025-08-30":0} where 1=available, 0=unavailable
    data.forEach((dateStr, status) {
      try {
        DateTime date = DateTime.parse(dateStr);
        if (date.year == year && date.month == month) {
          // Convert status numbers to brand names
          String statusStr;
          if (status == 1) {
            statusStr = 'Available';
          } else {
            statusStr = 'Closed';
          }
          dayMap[date.day] = statusStr;
        }
      } catch (e) {
        print('Error parsing date: $dateStr');
      }
    });

    if (dayMap.isEmpty) {
      toast("No schedule data available for current month.");
      return;
    }

    _showCalendarDialog(context, year, month, dayMap);
  }

  // Handle original API response format (status = 2)
  Future<void> _handleOriginalApiResponse(BuildContext context, Map<String, dynamic> data) async {
    print('Original API Response:');
    print(data);

    if (!data.containsKey('real_staff')) {
      toast("Invalid response format.");
      return;
    }

    final staff = data['real_staff'].firstWhere(
          (e) => e['first_name'] == widget.expertData.firstName,
      orElse: () => null,
    );

    if (staff == null || staff['calendar_data'] == null || staff['calendar_data'].isEmpty) {
      toast("No calendar data available.");
      return;
    }

    DateTime now = DateTime.now();
    final calendar = staff['calendar_data'].firstWhere(
          (cal) => cal['year'] == now.year && cal['month'] == now.month,
      orElse: () => null,
    );

    if (calendar == null) {
      toast("No schedule available for the current month.");
      return;
    }

    int year = calendar['year'];
    int month = calendar['month'];
    List days = calendar['days'];

    Map<int, String?> dayMap = {for (var d in days) d['day']: d['status']};

    _showCalendarDialog(context, year, month, dayMap);
  }

  // Show the calendar dialog
  void _showCalendarDialog(BuildContext context, int year, int month, Map<int, String?> dayMap) {
    DateTime firstDay = DateTime(year, month, 1);
    int totalDays = DateUtils.getDaysInMonth(year, month);

    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.expertData.fullName.validate(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMM().format(firstDay),
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                _buildWeekHeader(),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: _buildCalendarTable(firstDay, totalDays, dayMap),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCalendarShimmerPlaceholder(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 20, width: 150, color: Colors.grey[300]),
            const SizedBox(height: 8),
            Container(height: 14, width: 100, color: Colors.grey[300]),
            const SizedBox(height: 16),
            _buildWeekHeader(),
            const SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: List.generate(5, (_) {
                  return Row(
                    children: List.generate(7, (_) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16),
            Container(height: 40, width: 100, color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarTable(DateTime firstDay, int totalDays, Map<int, String?> dayMap) {
    List<TableRow> rows = [];

    // Move Sunday to the end (index 6)
    int startWeekday = (firstDay.weekday % 7); // Monday=1 -> 1, Sunday=7 -> 0
    int shiftedStart = (startWeekday + 6) % 7;

    int currentDay = 1;

    while (currentDay <= totalDays) {
      List<Widget> weekCells = [];

      for (int i = 0; i < 7; i++) {
        if (rows.isEmpty && i < shiftedStart) {
          weekCells.add(Container());
        } else if (currentDay <= totalDays) {
          String? status = dayMap[currentDay];
          bool isClosed = status == null || status.toLowerCase() == 'closed';

          weekCells.add(
            Container(
              height: 35,
              margin: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: isClosed ? Colors.red[100] : Colors.green[100],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$currentDay',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  // Replace icon with brand name text
                  Text(
                    status ?? 'Closed',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: isClosed ? Colors.red : Colors.green,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
          currentDay++;
        } else {
          weekCells.add(Container());
        }
      }

      rows.add(TableRow(children: weekCells));
    }

    return Table(children: rows);
  }

  Widget _buildWeekHeader() {
    final days = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return Row(
      children: days.map((d) {
        return Expanded(
          child: Center(
            child: Text(
              d,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }).toList(),
    );
  }
}