import 'package:flutter/material.dart';

class CalendarDayWidget extends StatelessWidget {
  final DateTime date;
  final bool isSelected;
  final bool isToday;
  final bool isCurrentMonth;

  const CalendarDayWidget({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isToday = false,
    this.isCurrentMonth = true,
  });

  @override
  Widget build(BuildContext context) {
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
        child: Text('${date.day}', style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
