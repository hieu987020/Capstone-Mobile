import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class GenderRatio extends StatefulWidget {
  final TextEditingController _gender;
  final String _defaultGender;
  GenderRatio(this._gender, this._defaultGender);
  @override
  State<GenderRatio> createState() =>
      _GenderRatioState(_gender, _defaultGender);
}

class _GenderRatioState extends State<GenderRatio> {
  _GenderRatioState(this.gender, this.defaultGender);
  final TextEditingController gender;
  final String defaultGender;

  String groupValue = "";

  @override
  void initState() {
    groupValue = defaultGender;
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
              title: const Text('Male'),
              leading: Radio<String>(
                value: "Male",
                groupValue: groupValue,
                activeColor: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    groupValue = value;
                    gender.value = TextEditingValue(text: value);
                  });
                },
              ),
            ),
          ),
          Container(
            width: 150,
            child: ListTile(
              title: const Text('Female'),
              leading: Radio<String>(
                value: "Female",
                groupValue: groupValue,
                activeColor: kPrimaryColor,
                onChanged: (String value) {
                  setState(() {
                    groupValue = value;
                    gender.value = TextEditingValue(text: value);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
