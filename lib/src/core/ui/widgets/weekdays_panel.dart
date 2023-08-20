import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Selecione os dias da semana',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DayButton(label: 'Seg'),
                DayButton(label: 'Ter'),
                DayButton(label: 'Qua'),
                DayButton(label: 'Qui'),
                DayButton(label: 'Sex'),
                DayButton(label: 'Sab'),
                DayButton(label: 'Dom'),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DayButton extends StatelessWidget {
  final String label;

  const DayButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        // Usar Ink ao invés de container para ter o splash
        child: Ink(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              border: Border.all(
                color: ConstantColors.grey,
              )),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                  fontSize: 12,
                  color: ConstantColors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
