import 'package:currencyfx/model/Datafilterform.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the date formatting library
import '../model/currencymodel.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 1000));
  DateTime endDate = DateTime.now().subtract(Duration(days: 900));
  List<CurrencyRate> filteredData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exchange Rate Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DateFilterForm(
              onFilter: (start, end) async {
                // Update filteredData when the filter is applied
                List<CurrencyRate> data = await filterData(start, end);
                setState(() {
                  startDate = start;
                  endDate = end;
                  filteredData = data;
                });
              },
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     List<CurrencyRate> data = await filterData(startDate, endDate);
            //     setState(() {
            //       filteredData = data;
            //     });
            //   },
            //   child: Text("Load Data"),
            // ),
            SizedBox(height: 16),
            Text(
              'Filtered Data Between ${DateFormat('dd-MMM-yy').format(startDate)} and ${DateFormat('dd-MMM-yy').format(endDate)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${DateFormat('dd-MMM-yy').format(filteredData[index].date)} ',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<CurrencyRate>> filterData(DateTime start, DateTime end) async {
    List<CurrencyRate> allData = await readCSV('assets/final.csv');
    return allData
        .where((entry) => entry.date.isAfter(start) && entry.date.isBefore(end))
        .toList();
  }
}
