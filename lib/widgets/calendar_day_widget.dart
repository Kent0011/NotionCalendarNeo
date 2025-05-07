import 'package:flutter/material.dart';
import '../models/event.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarDayWidget extends StatefulWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isCurrentMonth;
  final bool isHoliday;
  final List<Event> events;
  const CalendarDayWidget({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isCurrentMonth = true,
    this.isHoliday = false,
    required this.events,
  });

  @override
  State<CalendarDayWidget> createState() => _CalendarDayWidgetState();
}

class _CalendarDayWidgetState extends State<CalendarDayWidget> {
  @override
  Widget build(BuildContext context) {
    final events = widget.events
        .where((event) => isSameDay(widget.date, event.startDate))
        .toList()
      ..sort((a, b) => a.startDate.compareTo(b.startDate));

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
        color:
            widget.isSelected
                ? const Color.fromARGB(255, 245, 245, 245)
                : widget.isToday
                ? const Color.fromARGB(255, 241, 251, 254)
                : Colors.white,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            if (widget.date.weekday == 7)
              Text('${widget.date.day}', style: TextStyle(color: Colors.red))
            else if (widget.isHoliday)
              Text('${widget.date.day}', style: TextStyle(color: Colors.red))
            else if (widget.date.weekday == 6)
              Text('${widget.date.day}', style: TextStyle(color: Colors.blue))
            else
              Text('${widget.date.day}', style: TextStyle(color: Colors.black)),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2.0),
              child: Column(
                children: [
                  for (var event in events)
                    if (event.color == 'blue')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 211, 240, 253),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(color: Colors.blue, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else if (event.color == 'red')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 255, 225, 225),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(color: Colors.red, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else if (event.color == 'green')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 211, 253, 211),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(color: Colors.green, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else if (event.color == 'yellow')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 255, 251, 211),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else if (event.color == 'purple')
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 248, 226, 248),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: event.isAllDay() ? const Color.fromARGB(255, 245, 245, 245) : const Color.fromARGB(255, 255, 255, 255),
                          ),
                          width: 100,
                          child: Text(
                            event.title,
                            style: TextStyle(color: Colors.black, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
