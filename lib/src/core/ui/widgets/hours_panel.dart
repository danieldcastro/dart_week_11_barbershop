import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Selecione os horários de atendimento',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            for (int i = startTime; i <= endTime; i++)
              TimeButton(label: '${i.toString().padLeft(2, '0')}:00'),
            // PadLeft adiciona um caractere do lado esquerdo enquanto houver apenas um caractere, e no caso o caractere é "0"
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatelessWidget {
  final String label;

  const TimeButton({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 36,
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
    );
  }
}
