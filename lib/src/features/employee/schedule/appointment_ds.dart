import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  @override
  List<dynamic>? get appointments => [
        Appointment(
            subject: 'Daniel Marciano',
            startTime: DateTime.now(),
            endTime: DateTime.now().add(
              const Duration(hours: 1),
            )),
        Appointment(
            subject: 'Teste texto',
            startTime: DateTime.now(),
            endTime: DateTime.now().add(
              const Duration(hours: 5),
            ))
      ];
}
