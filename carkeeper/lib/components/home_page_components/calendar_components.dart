import 'package:carkeeper/styles.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class CalendarComponents extends StatefulWidget {
  @override
  State<CalendarComponents> createState() => _CalendarComponentsState();
}

class _CalendarComponentsState extends State<CalendarComponents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF06A66C), width: 3),
        borderRadius: BorderRadius.circular(90),
      ),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: TimerBuilder.periodic(const Duration(seconds: 1),
            builder: (context) {
          return Text(
            formatDate(DateTime.now(), [dd]),
            style: h5(mColor: Color(0xFF06A66C)),
          );
        }),
      ),
    );
  }
}
