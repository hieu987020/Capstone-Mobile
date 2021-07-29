import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthField extends StatefulWidget {
  DateOfBirthField(this._validate, this._labelText, this._controller);
  final String _validate;
  final String _labelText;
  final TextEditingController _controller;

  @override
  _DateOfBirthFieldState createState() =>
      _DateOfBirthFieldState(_validate, _labelText, _controller);
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  _DateOfBirthFieldState(this._validate, this._labelText, this._controller);
  final String _validate;
  final String _labelText;
  final TextEditingController _controller;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 8),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var f = new DateFormat('yyyy-MM-dd');
        String date = f.format(picked);
        _controller.value = TextEditingValue(text: date);
      });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
        child: TextFormField(
          onTap: () {
            _selectDate(context);
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          controller: _controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _labelText,
            contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return _validate;
            }
            return null;
          },
        ),
      ),
    );
  }
}
