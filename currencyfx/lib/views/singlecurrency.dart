import 'package:currencyfx/model/currencymodel.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controller/filterController.dart';

class CurrencyDataByDate extends StatefulWidget {
  @override
  _CurrencyDataByDateState createState() => _CurrencyDataByDateState();
}

class _CurrencyDataByDateState extends State<CurrencyDataByDate> {
  DateTime selectedDate = DateTime(2012);
  List<CurrencyRate> filteredData = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2012),
      lastDate: DateTime(2022),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        // Call the filterDataDate function when the date is selected
        filterData();
      });
    }
  }

  Future<void> filterData() async {
    List<CurrencyRate> data = await filterDataDate(selectedDate);
    setState(() {
      filteredData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Data by Date'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            filteredData[index].rates.entries.map((entry) {
                          return Row(
                            children: [
                              Text(entry.key),
                              const SizedBox(height: 30),
                              Text(entry.value)
                            ],
                          );
                        }).toList(),
                      ),
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
}
