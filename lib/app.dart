import 'package:capstone/screens/screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenManager(),
      routes: {
        Routes.manager: (context) => ScreenManager(),
        Routes.store: (context) => ScreenStore(),
        Routes.product: (context) => ScreenProduct(),
        Routes.camera: (context) => ScreenCamera(),
        Routes.dashboard: (context) => ScreenDashboard(),
      },
    );
  }
}
