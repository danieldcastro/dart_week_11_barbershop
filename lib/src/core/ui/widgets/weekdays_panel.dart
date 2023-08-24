// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  final List<String>? enabledDays;
  final ValueChanged<String> onDayPressed;
  //ValueChanged é isso: ValueChanged<T> = void Function(T value);
  const WeekdaysPanel(
      {super.key, required this.onDayPressed, this.enabledDays});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FittedBox(
          fit: BoxFit.scaleDown,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Selecione os dias da semana',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DayButton(
                  label: 'Seg',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Ter',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Qua',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Qui',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Sex',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Sab',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
                DayButton(
                  label: 'Dom',
                  onDayPressed: onDayPressed,
                  enabledDays: enabledDays,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DayButton extends StatefulWidget {
  final List<String>? enabledDays;

  final String label;
  final ValueChanged<String> onDayPressed;
  //ValueChanged é isso: ValueChanged<T> = void Function(T value);

  const DayButton({
    super.key,
    required this.label,
    required this.onDayPressed,
    this.enabledDays,
  });

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ConstantColors.grey;
    Color buttonColor = selected ? ConstantColors.brown : Colors.white;
    final buttonBorderColor =
        selected ? ConstantColors.brown : ConstantColors.grey;

    final DayButton(:enabledDays, :label, :onDayPressed) = widget;

    final disabledDay = enabledDays != null && !enabledDays.contains(label);

    if (disabledDay) {
      buttonColor = Colors.grey[400]!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disabledDay
            ? null
            : () {
                onDayPressed(label);
                setState(() {
                  selected = !selected;
                });
              },
        // Usar Ink ao invés de container para ter o splash
        child: Ink(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: buttonColor,
              border: Border.all(
                color: buttonBorderColor,
              )),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
