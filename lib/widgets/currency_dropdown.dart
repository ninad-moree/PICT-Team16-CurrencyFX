import 'package:flutter/material.dart';

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

    return DropdownButton<String>(
      value: selectedCurrency,
      onChanged: onChanged,
      items: currencies.map<DropdownMenuItem<String>>((String currency) {
        return DropdownMenuItem<String>(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
    );
  }
}
