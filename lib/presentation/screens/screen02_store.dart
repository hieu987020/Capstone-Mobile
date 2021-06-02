import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenStore extends StatelessWidget {
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
