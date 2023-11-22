import 'package:flutter/material.dart';

class DurationDropdown extends StatelessWidget {
  final String selectedDuration;
  final ValueChanged<String?>? onChanged;

  const DurationDropdown({
    super.key,
    required this.selectedDuration,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedDuration,
      onChanged: onChanged,
      items: [
        'Weekly',
        'Monthly',
        'Quarterly',
        'Yearly',
      ].map<DropdownMenuItem<String>>((String duration) {
        return DropdownMenuItem<String>(
          value: duration,
          child: Text(duration),
        );
      }).toList(),
    );
  }
}
