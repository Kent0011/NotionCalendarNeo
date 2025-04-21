import 'package:http/http.dart' as http;
import '../models/event.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class Api {

  // 選択された月のイベントをnotionにリクエストしEventのListを返す
  static Future<List<Event>> fetchEventList(DateTime selectedDay) async {
    
    await dotenv.load(fileName: '.env');

    final String apiKey = dotenv.env['API_KEY'] ?? '';
    final String databaseId = dotenv.env['DATABASE_ID'] ?? '';

    final int year = selectedDay.year;
    final int month = selectedDay.month;

    final response = await http.post(
      Uri.parse('https://api.notion.com/v1/databases/$databaseId/query'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Notion-Version': '2022-06-28',
      },
      body: json.encode({
        "filter": {
          "and": [
            {
              "property": "Date",
              "date": {"on_or_after": "$year-$month-01"},
            },
            {
              "property": "Date",
              "date": {"before": "$year-${month + 1}-01"},
            },
          ],
        },
        "sorts": [
          {"property": "Date", "direction": "ascending"},
        ],
      }),
    );

    if (response.statusCode == 200) {
      List<Event> events = [];
      Map<String, dynamic> decodedJson = json.decode(response.body);
      for (var event in decodedJson['results']) {
        Map<String, dynamic> eventinfo = parseEventList(event);
        Event ev = Event.fromJson(eventinfo);
        events.add(ev);
      }
      return events;
    } else {
      throw Exception('Failed to load events: ${response.statusCode}');
    }
  }

  // JsonをパースしてEventのfactoryに渡す
  static Map<String, dynamic> parseEventList(Map<String, dynamic> decodedJson) {
    // mapを初期化
    Map<String, dynamic> eventinfo = {};

    eventinfo['url'] = decodedJson['url'];
    eventinfo['title'] = decodedJson['properties']['Title']['title'][0]['text']['content'];
    eventinfo['startDate'] = decodedJson['properties']['Date']['date']['start'];
    eventinfo['endDate'] = decodedJson['properties']['Date']['date']['end'] ?? decodedJson['properties']['Date']['date']['start'];
    eventinfo['category'] = decodedJson['properties']['Category']['select']['name'];
    eventinfo['color'] = decodedJson['properties']['Category']['select']['color'];
    
    return eventinfo;
  }
}
