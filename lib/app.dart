import 'package:capstone/repositories/repositories.dart';
import 'package:capstone/screens/screens.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  final CommonRepository _repositories;

  const App(this._repositories);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenManager(_repositories.usersRepository),
      routes: {
        Routes.manager: (context) =>
            ScreenManager(_repositories.usersRepository),
        Routes.store: (context) => ScreenStore(),
        Routes.product: (context) =>
            ScreenProduct(_repositories.usersRepository),
        Routes.camera: (context) => ScreenCamera(),
        Routes.dashboard: (context) => ScreenDashboard(),
      },
    );
  }
}
