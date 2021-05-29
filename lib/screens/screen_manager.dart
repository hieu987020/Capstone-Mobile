import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';

class ScreenManager extends StatelessWidget {
  static const String routeName = '/manager';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Manager'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: NavigatorButton(),
      body: Column(
        children: [
          ManagerCardHeader('List Manager'),
          ManagerCard(
            'https://www.nicepng.com/png/full/131-1315000_kaneki-ken-ken-kaneki-png.png',
            'Hieu HD',
            'Book store Ho Chi Minh',
            'Active',
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
