import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ScreenManagerDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Dashboard',
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenHeaderText('Dashboard'),
              ScreenHeaderText('Dashboard'),
              ScreenHeaderText('Dashboard'),
            ]),
      ),
    );
  }
}
