import 'dart:developer';

import 'package:dw_barbershop/src/core/providers/application_providers.dart';
import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:dw_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:dw_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:dw_barbershop/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.pop(context);
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });

    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar colaborador'),
        ),
        body: barbershopAsyncValue.when(
          error: (e, s) {
            log('Erro ao carregar a página', error: e, stackTrace: s);

            return const Center(
              child: Text('Erro ao carregar a página'),
            );
          },
          loading: () => const BarbershopLoader(),
          data: (barbershopModel) {
            final BarbershopModel(:openingDays, :openingHours) =
                barbershopModel;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      children: [
                        const AvatarWidget(),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Checkbox.adaptive(
                                value: registerAdm,
                                onChanged: (value) {
                                  setState(() {
                                    registerAdm = !registerAdm;
                                    employeeRegisterVm
                                        .setRegisterADM(registerAdm);
                                  });
                                }),
                            const Expanded(
                              child: Text(
                                'Sou administrador e quero me cadastrar como colaborador',
                                style: TextStyle(fontSize: 14),
                              ),
                            )
                          ],
                        ),
                        Offstage(
                          offstage: registerAdm,
                          child: Column(
                            children: [
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: nameEC,
                                validator: registerAdm
                                    ? null
                                    : Validatorless.required(
                                        'Nome obrigatório'),
                                onTapOutside: (_) => context.unFocus(),
                                decoration:
                                    const InputDecoration(labelText: 'Nome'),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                  controller: emailEC,
                                  validator: registerAdm
                                      ? null
                                      : Validatorless.multiple([
                                          Validatorless.required(
                                              'Email obrigatório'),
                                          Validatorless.email('Email inválido')
                                        ]),
                                  onTapOutside: (_) => context.unFocus(),
                                  decoration: const InputDecoration(
                                      labelText: 'Email')),
                              const SizedBox(height: 24),
                              TextFormField(
                                  controller: passwordEC,
                                  validator: registerAdm
                                      ? null
                                      : Validatorless.multiple([
                                          Validatorless.required(
                                              'Senha obrigatória'),
                                          Validatorless.min(6,
                                              'Senha deve conter pelo menos 6 caracteres')
                                        ]),
                                  obscureText: true,
                                  onTapOutside: (_) => context.unFocus(),
                                  decoration: const InputDecoration(
                                      labelText: 'Senha')),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        WeekdaysPanel(
                            enabledDays: openingDays,
                            onDayPressed:
                                employeeRegisterVm.addOrRemoveWorkDays),
                        const SizedBox(height: 24),
                        HoursPanel(
                            enabledTimes: openingHours,
                            startTime: 6,
                            endTime: 23,
                            onHourPressed:
                                employeeRegisterVm.addOrRemoveWorkHours),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56)),
                          onPressed: () {
                            switch (formKey.currentState?.validate()) {
                              case false || null:
                                Messages.showError(
                                    'Existem campos inválidos', context);
                              case true:
                                final EmployeeRegisterState(
                                  workDays: List(isNotEmpty: hasWorkDays),
                                  workHours: List(isNotEmpty: hasWorkHours)
                                  //Destrucions usados aqui
                                ) = ref.watch(employeeRegisterVmProvider);

                                if (!hasWorkDays || !hasWorkHours) {
                                  Messages.showError(
                                      'Por favor, selecione os dias da semana e horário de atendimento',
                                      context);
                                  return;
                                }

                                final name = nameEC.text;
                                final email = emailEC.text;
                                final password = passwordEC.text;

                                employeeRegisterVm.register(
                                    email: email,
                                    name: name,
                                    password: password);
                            }
                          },
                          child: const Text('CADASTRAR COLABORADOR'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
