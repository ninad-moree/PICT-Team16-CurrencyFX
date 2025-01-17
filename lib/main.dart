import 'package:flutter/material.dart';

import 'screens/currency_exchange_page.dart';

void main() => runApp(const CurrencyExchangeApp());

class CurrencyExchangeApp extends StatelessWidget {
  const CurrencyExchangeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Exchange Rate Analysis',
      theme: ThemeData.dark(),
      home: const CurrencyExchangePage(),
    );
  }
}
//h