import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';

class ScreenCamera extends StatelessWidget {
  static const String routeName = '/camera';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Camera'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText('Camera'),
            HeaderText('Camera'),
            HeaderText('Camera'),
          ]),
      drawer: NavigatorButton(),
    );
  }
}
