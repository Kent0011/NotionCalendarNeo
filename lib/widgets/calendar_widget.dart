import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'calendar_day_widget.dart';
import '../models/event.dart';
import '../api/api.dart';

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
    return FutureBuilder<List<Event>>(
      future: Api.fetchEventList(selectedDay ?? DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return TableCalendar(
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, events) {
                return CalendarDayWidget(
                  date: date,
                  isCurrentMonth: date.month == focusedDay.month,
                  isToday: isSameDay(date, DateTime.now()),
                  isSelected: isSameDay(date, selectedDay),
                  events: [],
                );
              },
              outsideBuilder: (context, date, events) {
                return CalendarDayWidget(
                  date: date,
                  isCurrentMonth: false,
                  isToday: isSameDay(date, DateTime.now()),
                  isSelected: isSameDay(date, selectedDay),
                  events: [],
                );
              },
              selectedBuilder: (context, date, events) {
                return CalendarDayWidget(
                  date: date,
                  isCurrentMonth: date.month == focusedDay.month,
                  isToday: isSameDay(date, DateTime.now()),
                  isSelected: isSameDay(date, selectedDay),
                  events: [],
                );
              },
              todayBuilder: (context, date, events) {
                return CalendarDayWidget(
                  date: date,
                  isCurrentMonth: date.month == focusedDay.month,
                  isToday: isSameDay(date, DateTime.now()),
                  isSelected: isSameDay(date, selectedDay),
                  events: [],
                );
              },
              holidayBuilder: (context, date, events) {
                return CalendarDayWidget(
                  date: date,
                  isCurrentMonth: date.month == focusedDay.month,
                  isToday: isSameDay(date, DateTime.now()),
                  isSelected: isSameDay(date, selectedDay),
                  isHoliday: true,
                  events: [],
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
        if (snapshot.hasError) {
          return Text('エラー: ${snapshot.error}');
        }
        return TableCalendar(
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, date, events) {
              return CalendarDayWidget(
                date: date,
                isCurrentMonth: date.month == focusedDay.month,
                isToday: isSameDay(date, DateTime.now()),
                isSelected: isSameDay(date, selectedDay),
                events: snapshot.data ?? [],
              );
            },
            outsideBuilder: (context, date, events) {
              return CalendarDayWidget(
                date: date,
                isCurrentMonth: false,
                isToday: isSameDay(date, DateTime.now()),
                isSelected: isSameDay(date, selectedDay),
                events: snapshot.data ?? [],
              );
            },
            selectedBuilder: (context, date, events) {
              return CalendarDayWidget(
                date: date,
                isCurrentMonth: date.month == focusedDay.month,
                isToday: isSameDay(date, DateTime.now()),
                isSelected: isSameDay(date, selectedDay),
                events: snapshot.data ?? [],
              );
            },
            todayBuilder: (context, date, events) {
              return CalendarDayWidget(
                date: date,
                isCurrentMonth: date.month == focusedDay.month,
                isToday: isSameDay(date, DateTime.now()),
                isSelected: isSameDay(date, selectedDay),
                events: snapshot.data ?? [],
              );
            },
            holidayBuilder: (context, date, events) {
              return CalendarDayWidget(
                date: date,
                isCurrentMonth: date.month == focusedDay.month,
                isToday: isSameDay(date, DateTime.now()),
                isSelected: isSameDay(date, selectedDay),
                isHoliday: true,
                events: snapshot.data ?? [],
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
      },
    );
  }
}
