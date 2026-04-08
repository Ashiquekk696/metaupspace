class DashboardStats {
  const DashboardStats({
    required this.attendanceDays,
    required this.leaveBalance,
    required this.pendingRequests,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      attendanceDays: (json['attendanceDays'] as num?)?.toInt() ?? 0,
      leaveBalance: (json['leaveBalance'] as num?)?.toInt() ?? 0,
      pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
    );
  }

  final int attendanceDays;
  final int leaveBalance;
  final int pendingRequests;
}
