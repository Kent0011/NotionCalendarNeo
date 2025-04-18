class Event {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final bool isAllDay;
  final String category;

  Event({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.isAllDay,
    required this.category,
  });

  // ここはfromJsonをNotionのAPIのドキュメント見ながらしっかり作る --- 未実装
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      isAllDay: json['isAllDay'] as bool,
      category: json['category'] as String,
    );
  }
}
