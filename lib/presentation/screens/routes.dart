import 'package:capstone/presentation/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => ScreenDashboard());
        break;
      case '/store':
        return MaterialPageRoute(builder: (_) => ScreenStore());
        break;
      case '/manager':
        return MaterialPageRoute(builder: (_) => ScreenManager());
        break;
      case '/product':
        return MaterialPageRoute(builder: (_) => ScreenProduct());
        break;
      case '/camera':
        return MaterialPageRoute(builder: (_) => ScreenCamera());
        break;
      default:
        return null;
    }
  }
}
