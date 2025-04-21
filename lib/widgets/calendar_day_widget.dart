import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarDayWidget extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isCurrentMonth;
  final List<Event> events;
  const CalendarDayWidget({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isCurrentMonth = true,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {

    final events = this.events.where((event) => isSameDay(date, event.startDate)).toList();

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
          left: BorderSide(color: Colors.grey),
        ),
        color:
            isSelected
                ? const Color.fromARGB(255, 181, 221, 255)
                : isToday
                    ? const Color.fromARGB(255, 255, 209, 209)
                    : Colors.white,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Text('${date.day}', style: TextStyle(color: Colors.black)),
            for (var event in events)
              if (event.color == 'blue')
                Text(event.title, style: TextStyle(color: Colors.blue, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'red')
                Text(event.title, style: TextStyle(color: Colors.red, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'green')
                Text(event.title, style: TextStyle(color: Colors.green, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'yellow')
                Text(event.title, style: TextStyle(color: Colors.yellow, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'purple')
                Text(event.title, style: TextStyle(color: Colors.purple, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'orange')
                Text(event.title, style: TextStyle(color: Colors.orange, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else if (event.color == 'pink')
                Text(event.title, style: TextStyle(color: Colors.pink, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
              else
                Text(event.title, style: TextStyle(color: Colors.black, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis)
          ],
        ),
      ),
    );
  }
}
