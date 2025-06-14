import 'package:flutter/material.dart';
import 'widgets/calendar_widget.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 109, 163),
        ),
        useMaterial3: true,
      ),
      home: const CalendarPage(),
    );
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
      body: Column(
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
          Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey)),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: null,
          ),
        ],
      ),
    );
  }
}
