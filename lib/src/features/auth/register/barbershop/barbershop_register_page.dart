import 'package:dw_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_state.dart';
import 'package:dw_barbershop/src/features/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/messages.dart';
import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/weekdays_panel.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final barberShopRegisterVM =
        ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
          Messages.showError(
              'Desculpe, ocorreu um erro ao registrar a barbearia', context);
        case BarbershopRegisterStateStatus.success:
          Navigator.pushNamedAndRemoveUntil(
              context, '/home/adm', (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(children: [
              const SizedBox(height: 5),
              TextFormField(
                controller: nameEC,
                decoration: const InputDecoration(
                  hintText: 'Nome',
                ),
                validator: Validatorless.required('Nome obrigatório'),
                onTapOutside: (_) => context.unFocus(),
              ),
              const SizedBox(height: 24),
              TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  controller: emailEC,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Email obrigatório'),
                    Validatorless.email('Email inválido'),
                  ])),
              const SizedBox(height: 24),
              WeekdaysPanel(
                onDayPressed: (value) =>
                    barberShopRegisterVM.addOrRemoveOpenDay(value),
              ),
              const SizedBox(height: 24),
              HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (value) =>
                      barberShopRegisterVM.addOrRemoveOpenHour(value)),
              const SizedBox(height: 24),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56)),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case false || null:
                        Messages.showError('Formulário inválido', context);
                      case true:
                        barberShopRegisterVM.register(
                            nameEC.text, emailEC.text);
                    }
                  },
                  child: const Text(
                    'CADASTRAR ESTABELECIMENTO',
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
