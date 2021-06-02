import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenCamera extends StatelessWidget {
  String _value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Camera'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: DropdownButton(
          items: [
            DropdownMenuItem<String>(
              child: Text('All Status'),
              value: '1',
            ),
            DropdownMenuItem<String>(
              child: Text('Active'),
              value: '2',
            ),
            DropdownMenuItem<String>(
              child: Text('Pending'),
              value: '3',
            ),
            DropdownMenuItem<String>(
              child: Text('Inactive'),
              value: '4',
            ),
          ],
        ),
      ),
      drawer: NavigatorButton(),
    );
  }
}
