import 'package:currencyfx/model/currencymodel.dart';
import 'package:currencyfx/views/currency_exchange_page.dart';
import 'package:currencyfx/views/data.dart';
import 'package:currencyfx/views/singlecurrency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/liveexchange.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    readCSV('assets/Merged.csv');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CurrencyFX'),
      ),
      body: Center(
        child: Column(
          children: [
            DataScreen(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CurrencyDataByDate()),
                );
              },
              child:
                  Text('Click Here to know your currency on a particular date'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CurrencyExchangePage()),
                );
              },
              child: Text(
                  'Click here for Yearly,Monthly,Quartely graphs and charts of different Currencies'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
              child: Text('Click Here for Conversion of Currency'),
            ),
          ],
        ),
      ),
    );
  }
}
