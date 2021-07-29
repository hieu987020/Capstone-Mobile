import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenManagerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Dashboard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenHeaderText('Dashboard'),
            ScreenHeaderText('Dashboard'),
            ScreenHeaderText('Dashboard'),
          ]),
      drawer: ManagerNavigator(),
    );
  }
}
