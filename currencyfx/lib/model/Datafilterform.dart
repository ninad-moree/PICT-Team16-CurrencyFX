import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilterForm extends StatefulWidget {
  final Function(DateTime, DateTime) onFilter;

  DateFilterForm({required this.onFilter});

  @override
  _DateFilterFormState createState() => _DateFilterFormState();
}

class _DateFilterFormState extends State<DateFilterForm> {
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: TextEditingController(
                  text: startDate != null
                      ? DateFormat('dd-MMM-yy').format(startDate!)
                      : '',
                ),
                decoration: InputDecoration(labelText: 'Start Date'),
                readOnly: true,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                controller: TextEditingController(
                  text: endDate != null
                      ? DateFormat('dd-MMM-yy').format(endDate!)
                      : '',
                ),
                decoration: InputDecoration(labelText: 'End Date'),
                readOnly: true,
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () async {
                await _selectStartDate(context);
                await _selectEndDate(context);

                // Call the onFilter callback with the selected dates
                if (startDate != null && endDate != null) {
                  widget.onFilter(startDate!, endDate!);
                }
              },
              child: Text('Choose Dates'),
            ),
          ],
        ),
      ],
    );
  }
}