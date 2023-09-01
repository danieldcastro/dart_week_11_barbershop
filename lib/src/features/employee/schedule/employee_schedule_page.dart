import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/features/employee/schedule/appointment_ds.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EmployeeSchedulePage extends StatelessWidget {
  const EmployeeSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(children: [
        const Text(
          'Nome e sobrenome',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 44),
        Expanded(
          child: SfCalendar(
            timeZone: 'E. South America Standard Time',
            allowViewNavigation: true,
            view: CalendarView.day,
            showNavigationArrow: true,
            todayHighlightColor: ConstantColors.brown,
            showDatePickerButton: true,
            showTodayButton: true,
            dataSource: AppointmentDs(),
            onTap: (calendarTapDetails) {
              if (calendarTapDetails.appointments != null &&
                  calendarTapDetails.appointments!.isNotEmpty) {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    final dateFormat = DateFormat('dd/MM/yyyy');
                    final hourFormat = DateFormat('HH:mm');
                    return SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  calendarTapDetails
                                      .appointments?.first.subject,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 15),
                                const Text(
                                  'reservou um horário para o dia',
                                  style: TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  '${dateFormat.format(calendarTapDetails.date ?? DateTime.now())} às ${hourFormat.format(calendarTapDetails.date ?? DateTime.now())}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ]),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            appointmentBuilder: (context, calendarAppointmentDetails) {
              return Container(
                decoration: BoxDecoration(
                    color: ConstantColors.brown,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                    child: Text(
                  calendarAppointmentDetails.appointments.first.subject,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                )),
              );
            },
          ),
        ),
      ]),
    );
  }
}
