import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_day_widget.dart';
import '../models/event.dart';
import '../api/api.dart';

class CalendarWidget extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.onDaySelected,
  });

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Event> _events = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final events = await Api.fetchEventList(widget.focusedDay);
    setState(() {
      _events = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TableCalendar(
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (context, date, events) {
            return CalendarDayWidget(
              date: date,
              isCurrentMonth: date.month == widget.focusedDay.month,
              isToday: isSameDay(date, DateTime.now()),
              isSelected: isSameDay(date, widget.selectedDay),
              events: _events,
            );
          },
          outsideBuilder: (context, date, events) {
            return CalendarDayWidget(
              date: date,
              isCurrentMonth: false,
              isToday: isSameDay(date, DateTime.now()),
              isSelected: isSameDay(date, widget.selectedDay),
              events: _events,
            );
          },
          selectedBuilder: (context, date, events) {
            return CalendarDayWidget(
              date: date,
              isCurrentMonth: date.month == widget.focusedDay.month,
              isToday: isSameDay(date, DateTime.now()),
              isSelected: isSameDay(date, widget.selectedDay),
              events: _events,
            );
          },
          todayBuilder: (context, date, events) {
            return CalendarDayWidget(
              date: date,
              isCurrentMonth: date.month == widget.focusedDay.month,
              isToday: isSameDay(date, DateTime.now()),
              isSelected: isSameDay(date, widget.selectedDay),
              events: _events,
            );
          },
          holidayBuilder: (context, date, events) {
            return CalendarDayWidget(
              date: date,
              isCurrentMonth: date.month == widget.focusedDay.month,
              isToday: isSameDay(date, DateTime.now()),
              isSelected: isSameDay(date, widget.selectedDay),
              isHoliday: true,
              events: _events,
            );
          },
        ),
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: widget.focusedDay,
        selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
        onDaySelected: widget.onDaySelected,
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.symmetric(vertical: 4.0),
          cellPadding: const EdgeInsets.symmetric(vertical: 8.0),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        shouldFillViewport: true,
      ),
    );
  }
}
