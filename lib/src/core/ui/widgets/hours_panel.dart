import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;

  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
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
              TimeButton(
                  label: '${i.toString().padLeft(2, '0')}:00',
                  onHourPressed: onHourPressed,
                  value: i),
            // PadLeft adiciona um caractere do lado esquerdo enquanto houver apenas um caractere, e no caso o caractere é "0"
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  final String label;
  final int value;
  final ValueChanged<int> onHourPressed;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onHourPressed,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ConstantColors.grey;
    final buttonColor = selected ? ConstantColors.brown : Colors.white;
    final buttonBorderColor =
        selected ? ConstantColors.brown : ConstantColors.grey;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          selected = !selected;
          widget.onHourPressed(widget.value);
        });
      },
      child: Ink(
        width: 64,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            )),
        child: Center(
          child: Text(
            widget.label,
            style: TextStyle(
                fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
