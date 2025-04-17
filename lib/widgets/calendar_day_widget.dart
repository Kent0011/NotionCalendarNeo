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
          bottom: BorderSide(color: Colors.grey),
          right: BorderSide(color: Colors.grey),
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color.fromARGB(255, 47, 193, 255)
                  : isToday
                      ? const Color.fromARGB(255, 255, 0, 0)
                      : null,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                '${date.day}',
                style: TextStyle(
                  color: isSelected || isToday
                      ? Colors.white
                      : isCurrentMonth
                          ? Colors.black
                          : Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} 