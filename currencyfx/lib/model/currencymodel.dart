import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyRate {
  DateTime date;
  Map<dynamic, dynamic> rates;

  CurrencyRate({required this.date, required this.rates});
}

Future<List<CurrencyRate>> readCSV(String filePath) async {
  String csvData = await rootBundle.loadString(filePath);
  List<List<dynamic>> csvTable = const CsvToListConverter().convert(csvData);

  List<CurrencyRate> currencyRates = [];

  List<dynamic> currencyCodes = List.from(csvTable[0]);
  currencyCodes.removeAt(0);

  final dateFormat = DateFormat('dd-MMM-yy');

  for (int i = 1; i < csvTable.length; i++) {
    List<dynamic> row = csvTable[i];
    DateTime date = dateFormat.parse(row[0].toString());

    Map<dynamic, dynamic> rates = {};
    for (int j = 1; j < row.length; j++) {
      String rate = row[j].toString();
      rates[currencyCodes[j - 1]] = rate;
    }

    currencyRates.add(CurrencyRate(date: date, rates: rates));
  }

  return currencyRates;
}
