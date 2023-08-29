import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatefulWidget {
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final List<int>? enabledTimes;
  final bool singleSelection;
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes,
  }) : singleSelection = false;

  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enabledTimes,
  }) : singleSelection = true;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;

  @override
  Widget build(BuildContext context) {
    final HoursPanel(:singleSelection) = widget;
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
            for (int i = widget.startTime; i <= widget.endTime; i++)
              TimeButton(
                  timeSelected: lastSelection,
                  singleSelection: singleSelection,
                  enabledTimes: widget.enabledTimes,
                  label: '${i.toString().padLeft(2, '0')}:00',
                  onHourPressed: (timeSelected) {
                    widget.onHourPressed(timeSelected);
                    setState(() {
                      if (singleSelection) {
                        if (lastSelection == timeSelected) {
                          lastSelection = null;
                        } else {
                          lastSelection = timeSelected;
                        }
                      }
                    });
                  },
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
  final List<int>? enabledTimes;
  final bool singleSelection;
  final int? timeSelected;

  const TimeButton({
    super.key,
    required this.label,
    required this.value,
    required this.onHourPressed,
    required this.enabledTimes,
    required this.singleSelection,
    required this.timeSelected,
  });

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    bool selected = false;

    final TimeButton(
      :value,
      :label,
      :enabledTimes,
      :onHourPressed,
      :singleSelection,
      :timeSelected
    ) = widget;

    if (singleSelection) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          selected = true;
        } else {
          selected = false;
        }
      }
    }

    final textColor = selected ? Colors.white : ConstantColors.grey;
    var buttonColor = selected ? ConstantColors.brown : Colors.white;
    final buttonBorderColor =
        selected ? ConstantColors.brown : ConstantColors.grey;
    final disabledHour = enabledTimes != null && !enabledTimes.contains(value);
    if (disabledHour) {
      buttonColor = Colors.grey[400]!;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disabledHour
          ? null
          : () {
              setState(() {
                selected = !selected;
                onHourPressed(value);
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
            label,
            style: TextStyle(
                fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
