import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/helpers/messages.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/features/schedule/schedule_vm.dart';
import 'package:dw_barbershop/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  bool showCalendar = false;
  final formKey = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleVm = ref.watch(scheduleVmProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Form(
            key: formKey,
            child: Center(
                child: Column(
              children: [
                const AvatarWidget.hideUploadButton(),
                const SizedBox(height: 24),
                const Text(
                  'Nome e sobrenome',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 37),
                TextFormField(
                  controller: clientEC,
                  validator: Validatorless.required('Cliente obrigatório'),
                  decoration: const InputDecoration(labelText: 'Cliente'),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  validator:
                      Validatorless.required('Selecione a data do agendamento'),
                  controller: dateEC,
                  onTap: () {
                    setState(() {
                      showCalendar = true;
                    });
                    context.unFocus();
                  },
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Selecione uma data',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: Icon(
                      BarbershopIcons.calendar,
                      color: ConstantColors.brown,
                      size: 18,
                    ),
                  ),
                ),
                Offstage(
                  offstage: !showCalendar,
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      ScheduleCalendar(
                        cancelPressed: () {
                          setState(() {
                            showCalendar = false;
                          });
                        },
                        okPressed: (DateTime value) {
                          setState(() {
                            dateEC.text = dateFormat.format(value);
                            showCalendar = false;
                            scheduleVm.dateSelect(value);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                HoursPanel.singleSelection(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: scheduleVm.hourSelect,
                  enabledTimes: const [6, 7, 8],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Dados incompletos', context);
                      case true:
                        final hourSelected = ref.watch(scheduleVmProvider
                            .select((state) => state.scheduleHour != null));
                        if (hourSelected) {
                          //register
                        } else {
                          Messages.showError(
                              'Por favor, selecione um horário de atendimento',
                              context);
                        }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  child: const Text('AGENDAR'),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
