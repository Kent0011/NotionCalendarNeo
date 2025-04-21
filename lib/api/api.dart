import 'package:http/http.dart' as http;
import '../models/event.dart';
import 'dart:convert';

class Api {
  static const String apiKey = String.fromEnvironment('API_KEY', defaultValue: 'XXXXXXXXXX')  ;
  static const String databaseId = String.fromEnvironment('DATABASE_ID', defaultValue: 'XXXXXXXXXX');

  // 選択された月のイベントをnotionにリクエストしEventのListを返す
Future<List<Event>> fetchEventList(DateTime selectedDay) async {
  final year = selectedDay.year;
  final month = selectedDay.month;

  final response = await http.post(
    Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Notion-Version': '2022-06-28',
    },
    body: {
      "filter": {
        "and": [
          {
            "property": "Date",
            "date": {
              "on_or_after": "$year-$month-01"
            }
          },
          {
            "property": "Date",
            "date": {
              "before": "$year-${month+1}-01"
            }
          }
        ]
      },
      "sorts": [
        {
        "property": "Date",
        "direction": "ascending"
        }
      ],
    },
  );

  if (response.statusCode == 200) {
    List<Event> events = [];
    Map<String, dynamic> decodedJson = json.decode(response.body);
    for (var event in decodedJson['results']) {
      events.add(Event.fromJson(event));
    }
    return events;
  } else {
    throw Exception('Failed to load album');
  }
}
}

