import 'dart:ffi';

import 'package:currencyfx/model/currencymodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'VariableController.dart';

Future<List<CurrencyRate>> filterData(DateTime start, DateTime end) async {
  final Data controller = Get.put(Data());
  List<CurrencyRate> allData = await readCSV('assets/Merged.csv');
  controller.allData = allData;
  List<CurrencyRate> data = allData
      .where((entry) => entry.date.isAfter(start) && entry.date.isBefore(end))
      .toList();
  return data;
}

Future<List<CurrencyRate>> filterDataDate(DateTime date) async {
  final Data controller = Get.put(Data());
  List<CurrencyRate> allData = await readCSV('assets/Merged.csv');

  List<CurrencyRate> data =
      allData.where((entry) => entry.date.isAtSameMomentAs(date)).toList();

  return data;
}

Future<Map<DateTime, double>> extractCurrencyData(
    Future<List<CurrencyRate>> filteredData, String currencyCode) async {
  Map<DateTime, double> currencyData = {};
  final Data controller = Get.put(Data());
  List<CurrencyRate> actualFilteredData = await filteredData;
  String targetString = 'U.S. dollar   (USD)';
  for (var entry in actualFilteredData) {
    double ratio = 0.0;
    String matchingKey = entry.rates.keys.firstWhere(
        (key) => key.trim() == targetString.trim(),
        orElse: () => '');
    String matchingKey2 = entry.rates.keys.firstWhere(
        (element) => element.trim() == currencyCode.trim(),
        orElse: () => '');

    if (matchingKey.isNotEmpty && matchingKey2.isNotEmpty) {
      double value1 = double.parse(entry.rates[matchingKey]!);
      double value2 = double.parse(entry.rates[matchingKey2]!);
      ratio = value2 / value1;
      currencyData[entry.date] = ratio;
    }
    // if (controller.maxDate == null ||
    //     ratio > currencyData[controller.maxDate!]!) {
    //   controller.maxDate = entry.date;
    // }

    // if (controller.minDate == null ||
    //     ratio < currencyData[controller.minDate!]!) {
    //   controller.minDate = entry.date;
    // }
  }
  controller.maxVal.value =
      currencyData.values.  reduce((max, e) => max > e ? max : e);
  controller.minVal.value =
      currencyData.values.reduce((min, e) => min < e ? min : e);

  return currencyData;
}

Future<double> filterDate(DateTime date, String currencyCode) async {
  final Data controller = Get.put(Data());
  double value2 = 0.0;
  List<CurrencyRate> allData = await readCSV('assets/Merged.csv');
  List<CurrencyRate> data =
      allData.where((entry) => entry.date.isAtSameMomentAs(date)).toList();
  for (var entry in data) {
    String matchingKey2 = entry.rates.keys.firstWhere(
        (element) => element.trim() == currencyCode.trim(),
        orElse: () => '');

    if (matchingKey2.trim() == currencyCode.trim()) {
      value2 = double.parse(entry.rates[matchingKey2]!);
      break;
    }
  }

  return value2;
}
