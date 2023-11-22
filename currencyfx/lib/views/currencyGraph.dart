import 'package:currencyfx/controller/VariableController.dart';
import 'package:currencyfx/controller/filterController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CurrencyGraph extends StatefulWidget {
  List<dynamic> filteredData;
  CurrencyGraph({Key? key, required this.filteredData}) : super(key: key);

  @override
  _CurrencyGraphState createState() => _CurrencyGraphState();
}

class _CurrencyGraphState extends State<CurrencyGraph> {
  final Data controller = Get.put(Data());

  String selectedCurrencyCode = 'Australian dollar   (AUD)';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: extractCurrencyData(
        filterData(controller.startDate, controller.endDate),
        selectedCurrencyCode,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          Map<DateTime, double> currencyData =
              snapshot.data as Map<DateTime, double>;

          return buildChart(currencyData);
        }
      },
    );
  }

  Widget buildChart(Map<DateTime, double> currencyData) {
    final Data controller = Get.put(Data());

    return Scaffold(
      appBar: AppBar(title: const Text('Currency Graph')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(selectedCurrencyCode),
                PopupMenuButton<String>(
                  initialValue: selectedCurrencyCode,
                  onSelected: (String value) {
                    setState(() {
                      selectedCurrencyCode = value;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return controller.allcurrencies
                        .map<PopupMenuEntry<String>>((dynamic currencyCode) {
                      return PopupMenuItem<String>(
                        value: currencyCode.toString(),
                        child: Text(currencyCode.toString()),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
            Container(
              height: 500,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: true),
                  borderData: FlBorderData(
                    show: true,
                    border:
                        Border.all(color: const Color(0xff37434d), width: 1),
                  ),
                  titlesData: buildTitlesData(currencyData),
                  minY: currencyData.values
                          .reduce((min, e) => min < e ? min : e) *
                      0.990,
                  maxY: currencyData.values
                          .reduce((max, e) => max > e ? max : e) *
                      1.01,
                  lineBarsData: [
                    LineChartBarData(
                      spots: currencyData.entries.map((entry) {
                        return FlSpot(
                            entry.key.millisecondsSinceEpoch.toDouble(),
                            entry.value);
                      }).toList(),
                      isCurved: false,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Max Value: ${controller.maxVal.value.toStringAsFixed(3)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Change the color as needed
              ),
            ),
            Text(
              'Min Value: ${controller.minVal.value.toStringAsFixed(3)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Change the color as needed
              ),
            ),
          ],
        ),
      ),
    );
  }

  FlTitlesData buildTitlesData(Map<DateTime, double> currencyData) {
    return FlTitlesData(
      leftTitles: AxisTitles(
        axisNameSize: 30,
        axisNameWidget: Text(selectedCurrencyCode),
        sideTitles: const SideTitles(
          reservedSize: 40,
          interval: 2,
          showTitles: true,
        ),
      ),
      bottomTitles: AxisTitles(
        axisNameWidget: Text(
            '${formatDate(currencyData.entries.first.key)} to ${formatDate(currencyData.entries.last.key)}'),
      ),
      rightTitles: const AxisTitles(axisNameWidget: Text("")),
      topTitles: const AxisTitles(axisNameWidget: Text("")),
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
