import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_day_widget.dart';

class CalendarWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) {
          return CalendarDayWidget(
            date: date,
            isCurrentMonth: date.month == focusedDay.month,
            isToday: isSameDay(date, DateTime.now()),
            isSelected: isSameDay(date, selectedDay),
          );
        },
        outsideBuilder: (context, date, events) {
          return CalendarDayWidget(
            date: date,
            isCurrentMonth: false,
            isToday: isSameDay(date, DateTime.now()),
            isSelected: isSameDay(date, selectedDay),
          );
        },
        selectedBuilder: (context, date, events) {
          return CalendarDayWidget(
            date: date,
            isCurrentMonth: date.month == focusedDay.month,
            isToday: isSameDay(date, DateTime.now()),
            isSelected: isSameDay(date, selectedDay),
          );
        },
        todayBuilder: (context, date, events) {
          return CalendarDayWidget(
            date: date,
            isCurrentMonth: date.month == focusedDay.month,
            isToday: isSameDay(date, DateTime.now()),
            isSelected: isSameDay(date, selectedDay),
          );
        },
      ),
      firstDay: DateTime.utc(2000, 1, 1),
      lastDay: DateTime.utc(2100, 12, 31),
      focusedDay: focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: onDaySelected,
      calendarStyle: CalendarStyle(
        cellMargin: const EdgeInsets.symmetric(vertical: 4.0),
        cellPadding: const EdgeInsets.symmetric(vertical: 8.0),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
      rowHeight: 120.0,
    );
  }
} 