import 'package:flutter/material.dart';

import 'constants.dart';

class CurrencyDropdown extends StatelessWidget {
  final String selectedCurrency;
  final List<String> currencies;
  final ValueChanged<String?>? onChanged;

  const CurrencyDropdown({
    super.key,
    required this.selectedCurrency,
    required this.currencies,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!currencies.contains(selectedCurrency)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onChanged?.call(currencies.isNotEmpty ? currencies.first : null);
      });
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[900], // Dark background color
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: DropdownButton<String>(
        value: selectedCurrency,
        onChanged: onChanged,
        dropdownColor: Colors.grey[900], // Dark dropdown background color
        underline: Container(),
        items: currencies.map<DropdownMenuItem<String>>((String currency) {
          return DropdownMenuItem<String>(
            value: currency,
            child: Text(
              currency.trim(),
              style: kDropDownMenuTextStyle.copyWith(color: Colors.white),
            ),
          );
        }).toList(),
      ),
    );
  }
}
