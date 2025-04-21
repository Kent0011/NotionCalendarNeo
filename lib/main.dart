import 'package:flutter/material.dart';
import 'widgets/calendar_widget.dart';
import 'models/event.dart';
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert' show json;
@JsonSerializable()

const apiKey = String.fromEnvironment('API_KEY', defaultValue: 'XXXXXXXXXX');
const databaseId = String.fromEnvironment('DATABASE_ID', defaultValue: 'XXXXXXXXXX');


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCN',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 109, 163)),
        useMaterial3: true,
      ),
      home: const CalendarPage(),
    );
  }
}

// 選択された月のイベントをnotionにリクエストしEventのListを返す
Future<List<Event>> fetchEvent(DateTime selectedDay) async {
  final year = selectedDay.year;
  final month = selectedDay.month;

  // ここでyearとmonthが一致するDBの列をjson形式で取得し、responseに入れる　---　未実装
  final response = await http.get(
    Uri.parse('https://api.notion.com/v1/databases/$databaseId/query?filter_properties=${property_id_1}'),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Notion-Version': '2022-06-28',
    },
  );
  // ここでyearとmonthが一致するDBの列をjson形式で取得し、responseに入れる　---　未実装

  if (response.statusCode == 200) {
    List<Event> events = [];
    Map<String, dynamic> decodedJson = json.decode(response.body);
    decodedJson.forEach((key, value) => 
      events.add(Event.fromJson(decodedJson[key]))
    );
    return events;
  } else {
    throw Exception('Failed to load album');
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notion Calendar Neo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Expanded(
              child: CalendarWidget(
                focusedDay: _focusedDay,
                selectedDay: _selectedDay,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

