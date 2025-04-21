class Event {
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String category;
  final String url;
  final String color;

  Event({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.url,
    required this.color,
  });

  // ここはfromJsonをNotionのAPIのドキュメント見ながらしっかり作る --- 未実装
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      title: json['title'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      category: json['category'] as String,
      url: json['url'] as String,
      color: json['color'] as String,
    );
  }
}
