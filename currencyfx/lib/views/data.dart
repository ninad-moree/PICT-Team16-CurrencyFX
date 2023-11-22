import 'package:currencyfx/controller/VariableController.dart';
import 'package:currencyfx/controller/filterController.dart';
import 'package:currencyfx/model/Datafilterform.dart';
import 'package:currencyfx/views/currencyGraph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../model/currencymodel.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final Data controller = Get.put(Data());

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
                List<CurrencyRate> data = await filterData(start, end);
                setState(() {
                  controller.startDate = start;
                  controller.endDate = end;
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

            ElevatedButton(
                onPressed: () {
                  Get.to(() => CurrencyGraph(
                        filteredData: filteredData,
                      ));
                },
                child: Text('Graphs')),
          ],
        ),
      ),
    );
  }
}
