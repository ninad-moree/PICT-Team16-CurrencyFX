import 'package:flutter/material.dart';

import 'constants.dart';

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
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: DropdownButton<String>(
          value: selectedDuration,
          onChanged: onChanged,
          dropdownColor: Colors.grey[900],
          underline: Container(),
          items: [
            'Monthly',
            'Quarterly',
            'Yearly',
          ].map<DropdownMenuItem<String>>((String duration) {
            return DropdownMenuItem<String>(
              value: duration,
              child: Text(
                duration,
                style: kDropDownMenuTextStyle.copyWith(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
