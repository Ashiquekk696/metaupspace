class AttendanceItem {
  const AttendanceItem({
    required this.id,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.hours,
    required this.status,
  });

  factory AttendanceItem.fromJson(Map<String, dynamic> json) {
    return AttendanceItem(
      id: json['id'] as String? ?? '',
      date: json['date'] as String? ?? '',
      checkIn: json['checkIn'] as String? ?? '',
      checkOut: json['checkOut'] as String? ?? '',
      hours: json['hours'] as String? ?? '',
      status: json['status'] as String? ?? '',
    );
  }

  final String id;
  final String date;
  final String checkIn;
  final String checkOut;
  final String hours;
  final String status;
}
