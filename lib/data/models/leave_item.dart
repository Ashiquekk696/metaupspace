class LeaveItem {
  const LeaveItem({
    required this.id,
    required this.type,
    required this.range,
    required this.status,
    required this.days,
  });

  factory LeaveItem.fromJson(Map<String, dynamic> json) {
    return LeaveItem(
      id: json['id'] as String? ?? '',
      type: json['type'] as String? ?? '',
      range: json['range'] as String? ?? '',
      status: json['status'] as String? ?? '',
      days: (json['days'] as num?)?.toInt() ?? 0,
    );
  }

  final String id;
  final String type;
  final String range;
  final String status;
  final int days;
}
