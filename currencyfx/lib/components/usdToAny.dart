import 'package:currencyfx/network.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map currencies;
  const UsdToAny({Key? key, @required this.rates, required this.currencies})
      : super(key: key);

  @override
  _UsdToAnyState createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = 'Converted Currency will be shown here :)';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          // width: w / 3,
          padding: const EdgeInsets.all(20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'USD to Any Currency',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  key: const ValueKey('usd'),
                  controller: usdController,
                  decoration: const InputDecoration(hintText: 'Enter USD'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_rounded),
                        iconSize: 20,
                        elevation: 10,
                        isExpanded: true,
                        underline: Container(
                          height: 2,
                          color: Colors.grey.shade400,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: widget.currencies.keys
                            .toSet()
                            .toList()
                            .map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),

                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            answer = '${usdController.text} USD = ${convertusd(widget.rates, usdController.text,
                                    dropdownValue)} $dropdownValue';
                          });
                        },
                        child: const Text('Convert'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                Container(child: Text(answer))
              ])),
    );
  }
}
