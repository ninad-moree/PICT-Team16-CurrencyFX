import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/services.dart';

import '../model/chart.dart';
import '../widgets/currency_dropdown.dart';
import '../widgets/duration_dropdown.dart';

enum DurationType { weekly, monthly, quarterly, yearly }

class CurrencyExchangePage extends StatefulWidget {
  const CurrencyExchangePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CurrencyExchangePageState createState() => _CurrencyExchangePageState();
}

class _CurrencyExchangePageState extends State<CurrencyExchangePage> {
  String selectedCurrency1 = 'USD';
  String selectedCurrency2 = 'EUR';
  String selectedDuration = 'Yearly';
  int selectedYear = 2022;

  late List<String> currencyColumns = [];
  late List<List<dynamic>> csvData = [];

  DurationType selectedDurationType = DurationType.monthly;

  @override
  void initState() {
    super.initState();
    loadCSVData(selectedYear);
  }

  Future<void> loadCSVData(int selectedYear) async {
    String csvString = await rootBundle
        .loadString('csvs/Exchange_Rate_Report_$selectedYear.csv');

    List<List<dynamic>> parsedCsv =
        const CsvToListConverter().convert(csvString);
    currencyColumns = parsedCsv[0].skip(1).cast<String>().toList();

    setState(() {
      csvData = parsedCsv;
    });
  }

  List<ChartSampleData> getChartData(String currency1, String currency2) {
    List<ChartSampleData> chartData = [];

    int indexCurrency1 = currencyColumns.indexOf(currency1) + 1;
    int indexCurrency2 = currencyColumns.indexOf(currency2) + 1;

    for (int i = 1; i < csvData.length; i++) {
      DateTime? date = DateFormat('dd-MMM-yy').parse(csvData[i][0].toString());
      double valueCurrency1 =
          double.tryParse(csvData[i][indexCurrency1].toString()) ?? 0.0;
      double valueCurrency2 =
          double.tryParse(csvData[i][indexCurrency2].toString()) ?? 0.0;

      if (valueCurrency1 != 0.0 && valueCurrency2 != 0.0) {
        double ratio = valueCurrency2 / valueCurrency1;
        chartData.add(ChartSampleData(date, ratio));
      }
    }

    return chartData;
  }

  Widget buildChart() {
    if (csvData.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.yMMM(),
          interval: 1, // Set an appropriate interval
          // labelRotation: 90,
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: 'Value of $selectedCurrency2 wrt $selectedCurrency1',
          ),
        ),
        series: <FastLineSeries<ChartSampleData, DateTime>>[
          FastLineSeries<ChartSampleData, DateTime>(
            dataSource: getChartData(
              selectedCurrency1,
              selectedCurrency2,
            ),
            xValueMapper: (ChartSampleData sales, _) => sales.time,
            yValueMapper: (ChartSampleData sales, _) => sales.value,
          ),
        ],
        plotAreaBackgroundColor: Colors.white,
        plotAreaBorderColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Exchange Rate Analysis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CurrencyDropdown(
              selectedCurrency: selectedCurrency1,
              currencies: currencyColumns,
              onChanged: (newValue) {
                setState(() {
                  selectedCurrency1 = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            CurrencyDropdown(
              selectedCurrency: selectedCurrency2,
              currencies: currencyColumns,
              onChanged: (newValue) {
                setState(() {
                  selectedCurrency2 = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            DurationDropdown(
              selectedDuration: selectedDuration,
              onChanged: (newValue) {
                setState(() {
                  selectedDuration = newValue!;
                });
              },
            ),
            if (selectedDuration == 'Yearly')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButton<int>(
                  value: selectedYear,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue ?? 2022;
                      loadCSVData(selectedYear);
                    });
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    11,
                    (index) {
                      return DropdownMenuItem<int>(
                        value: 2012 + index,
                        child: Text((2012 + index).toString()),
                      );
                    },
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: buildChart(),
            ),
          ],
        ),
      ),
    );
  }
}
