import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CameraTypeRatio extends StatefulWidget {
  final TextEditingController controller;
  final String defaultValue;
  CameraTypeRatio({this.controller, this.defaultValue});
  @override
  State<CameraTypeRatio> createState() =>
      _CameraTypeRatioState(controller, defaultValue);
}

class _CameraTypeRatioState extends State<CameraTypeRatio> {
  _CameraTypeRatioState(this.controller, this.defaultValue);
  final TextEditingController controller;
  final String defaultValue;

  String groupValue = "";

  @override
  void initState() {
    groupValue = defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        brightness: Brightness.dark,
        unselectedWidgetColor: kPrimaryColor,
        radioTheme: RadioThemeData(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: ListTile(
              title: const Text('Counter'),
              leading: Radio<String>(
                value: "Counter",
                groupValue: groupValue,
                activeColor: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    groupValue = value;
                  });
                  controller.value = TextEditingValue(text: '1');
                },
              ),
            ),
          ),
          Container(
            width: 150,
            child: ListTile(
              title: const Text('Emotion'),
              leading: Radio<String>(
                value: "Emotion",
                groupValue: groupValue,
                activeColor: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    groupValue = value;
                  });
                  controller.value = TextEditingValue(text: '2');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
