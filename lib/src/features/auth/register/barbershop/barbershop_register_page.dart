import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/weekdays_panel.dart';

class BarbershopRegisterPage extends StatelessWidget {
  const BarbershopRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 5),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nome',
              ),
              validator: Validatorless.required('Nome obrigatório'),
            ),
            const SizedBox(height: 24),
            TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                validator: Validatorless.multiple([
                  Validatorless.required('Email obrigatório'),
                  Validatorless.email('Email inválido'),
                ])),
            const SizedBox(height: 24),
            const WeekdaysPanel(),
            const SizedBox(height: 24),
            const HoursPanel(startTime: 6, endTime: 23),
            const SizedBox(height: 24),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56)),
                onPressed: () {},
                child: const Text(
                  'CADASTRAR ESTABELECIMENTO',
                ))
          ]),
        ),
      ),
    );
  }
}
