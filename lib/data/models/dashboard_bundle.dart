import 'package:metaupspace/data/models/attendance_item.dart';
import 'package:metaupspace/data/models/dashboard_stats.dart';
import 'package:metaupspace/data/models/holiday_item.dart';
import 'package:metaupspace/data/models/leave_item.dart';

class DashboardBundle {
  const DashboardBundle({
    required this.stats,
    required this.leaves,
    required this.attendance,
    required this.holidays,
  });

  factory DashboardBundle.fromJson(Map<String, dynamic> json) {
    final statsRaw = json['stats'];
    final leavesRaw = json['leaves'];
    final attendanceRaw = json['attendance'];
    final holidaysRaw = json['holidays'];
    return DashboardBundle(
      stats: statsRaw is Map<String, dynamic>
          ? DashboardStats.fromJson(statsRaw)
          : const DashboardStats(
              attendanceDays: 0,
              leaveBalance: 0,
              pendingRequests: 0,
            ),
      leaves: (leavesRaw is List<dynamic>)
          ? leavesRaw
              .whereType<Map<String, dynamic>>()
              .map(LeaveItem.fromJson)
              .toList()
          : <LeaveItem>[],
      attendance: (attendanceRaw is List<dynamic>)
          ? attendanceRaw
              .whereType<Map<String, dynamic>>()
              .map(AttendanceItem.fromJson)
              .toList()
          : <AttendanceItem>[],
      holidays: (holidaysRaw is List<dynamic>)
          ? holidaysRaw
              .whereType<Map<String, dynamic>>()
              .map(HolidayItem.fromJson)
              .toList()
          : <HolidayItem>[],
    );
  }

  final DashboardStats stats;
  final List<LeaveItem> leaves;
  final List<AttendanceItem> attendance;
  final List<HolidayItem> holidays;
}
