import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StatusDropdown extends StatefulWidget {
  final String model;
  final String defaultValue;
  final TextEditingController controller;
  final void Function() callFunc;
  StatusDropdown({
    @required this.model,
    @required this.defaultValue,
    @required this.controller,
    @required this.callFunc,
  });

  @override
  State<StatusDropdown> createState() =>
      StatusDropdownState(model, defaultValue, controller, callFunc);
}

class StatusDropdownState extends State<StatusDropdown> {
  final String model;
  final String defaultValue;
  final TextEditingController controller;
  final void Function() callFunc;
  String selectedValue = "";
  var _menu1 = ['All', 'Active', 'Pending', 'Inactive'];

  @override
  void initState() {
    if (defaultValue.isEmpty || defaultValue == null) {
      selectedValue = "All";
    } else {
      selectedValue = defaultValue;
    }
    super.initState();
  }

  StatusDropdownState(
      this.model, this.defaultValue, this.controller, this.callFunc);
  @override
  Widget build(BuildContext context) {
    if (model == 'product' || model == 'category') {
      _menu1 = ['All', 'Active', 'Inactive'];
    }
    return DropdownButton<String>(
      value: selectedValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 15,
      iconEnabledColor: Colors.black,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (newValue) {
        setState(() {
          selectedValue = newValue;
        });
        if (newValue == "All") {
          controller.value = TextEditingValue(text: "0");
        }
        if (newValue == "Active") {
          controller.value = TextEditingValue(text: "1");
        }
        if (newValue == "Pending") {
          controller.value = TextEditingValue(text: "3");
        }
        if (newValue == "Inactive") {
          controller.value = TextEditingValue(text: "2");
        }
        callFunc();
      },
      items: _menu1.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class StackNum extends StatefulWidget {
  final String defaultValue;
  final TextEditingController controller;
  StackNum({this.defaultValue, this.controller});

  @override
  State<StackNum> createState() => StackNumState(defaultValue, controller);
}

class StackNumState extends State<StackNum> {
  final String defaultValue;
  final TextEditingController controller;
  String selectedValue = "";
  var _menu1 = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30'
  ];

  @override
  void initState() {
    if (defaultValue.isEmpty || defaultValue == null) {
      selectedValue = "1";
    } else {
      selectedValue = defaultValue;
    }
    super.initState();
  }

  StackNumState(this.defaultValue, this.controller);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        isExpanded: true,
        elevation: 16,
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
        onChanged: (String newValue) {
          setState(() {
            selectedValue = newValue;
          });
          controller.value = TextEditingValue(text: newValue);
        },
        items: _menu1.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
