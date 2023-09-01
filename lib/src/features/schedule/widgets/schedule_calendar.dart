import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/ui/helpers/messages.dart';

class ScheduleCalendar extends StatefulWidget {
  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  final List<String> workDays;

  const ScheduleCalendar(
      {super.key,
      required this.cancelPressed,
      required this.okPressed,
      required this.workDays});

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;

  late final List<int> weekDaysEnabled;

  int convertWeekDay(String weekDay) {
    return switch (weekDay.toLowerCase()) {
      'seg' => DateTime.monday,
      'ter' => DateTime.tuesday,
      'qua' => DateTime.wednesday,
      'qui' => DateTime.thursday,
      'sex' => DateTime.friday,
      'sab' => DateTime.saturday,
      'dom' => DateTime.sunday,
      _ => 0,
    };
  }

  @override
  void initState() {
    weekDaysEnabled = widget.workDays.map(convertWeekDay).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(
            0xFFe6e2e9,
          ),
          borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        TableCalendar(
          availableGestures: AvailableGestures.none,
          headerStyle: const HeaderStyle(titleCentered: true),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 01, 01),
          lastDay: DateTime.now().add(
            const Duration(days: 365 * 10),
          ),
          calendarFormat: CalendarFormat.month,
          locale: 'pt_BR',
          enabledDayPredicate: (day) => weekDaysEnabled.contains(day.weekday),
          availableCalendarFormats: const {
            CalendarFormat.month: 'month',
          },
          onDaySelected: (selectedDay, focusedDay) => setState(() {
            this.selectedDay = selectedDay;
          }),
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          calendarStyle: CalendarStyle(
            selectedDecoration: const BoxDecoration(
                color: ConstantColors.brown, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(
                color: ConstantColors.brown.withOpacity(0.4),
                shape: BoxShape.circle),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: widget.cancelPressed,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ConstantColors.brown),
                )),
            TextButton(
                onPressed: () => selectedDay == null
                    ? Messages.showError('Por favor, selecione um dia', context)
                    : widget.okPressed(selectedDay!),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: ConstantColors.brown),
                )),
          ],
        )
      ]),
    );
  }
}
