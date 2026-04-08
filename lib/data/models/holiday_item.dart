class HolidayItem {
  const HolidayItem({
    required this.id,
    required this.title,
    required this.date,
    required this.note,
  });

  factory HolidayItem.fromJson(Map<String, dynamic> json) {
    return HolidayItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      date: json['date'] as String? ?? '',
      note: json['note'] as String? ?? '',
    );
  }

  final String id;
  final String title;
  final String date;
  final String note;
}
