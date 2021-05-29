import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';

class ScreenStore extends StatelessWidget {
  static const String routeName = '/store';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Store'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderText('Store'),
            HeaderText('Store'),
            HeaderText('Store'),
          ]),
      drawer: NavigatorButton(),
    );
  }
}
