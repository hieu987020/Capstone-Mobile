import 'package:flutter/material.dart';

class StatusDropdown extends StatefulWidget {
  //const StatusDropdown({Key? key}) : super(key: key);

  @override
  State<StatusDropdown> createState() => _StatusDropdownState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _StatusDropdownState extends State<StatusDropdown> {
  String dropdownValue = 'Active';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 15,
      iconEnabledColor: Colors.black,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['All', 'Active', 'Pending', 'Inactive']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
