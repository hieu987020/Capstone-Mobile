import 'package:capstone/presentation/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      //? Admin
      case '/':
        return MaterialPageRoute(builder: (_) => ScreenLogin());
        break;
      case '/admin_dashboard':
        return MaterialPageRoute(builder: (_) => ScreenAdminDashboard());
        break;
      case '/store':
        return MaterialPageRoute(builder: (_) => ScreenStore());
        break;
      case '/manager':
        return MaterialPageRoute(builder: (_) => ScreenManager());
        break;
      case '/category':
        return MaterialPageRoute(builder: (_) => ScreenCategory());
        break;
      case '/product':
        return MaterialPageRoute(builder: (_) => ScreenProduct());
        break;
      case '/camera':
        return MaterialPageRoute(builder: (_) => ScreenCamera());
        break;

      //? Manager
      case '/manager_dashboard':
        return MaterialPageRoute(builder: (_) => ScreenManagerDashboard());
        break;
      case '/shelf':
        return MaterialPageRoute(builder: (_) => ScreenShelf());
        break;
      case '/video':
        return MaterialPageRoute(builder: (_) => ScreenVideo());
        break;
      case '/manager_product':
        return MaterialPageRoute(builder: (_) => ScreenProductManager());
        break;
      case '/manager_camera':
        return MaterialPageRoute(builder: (_) => ScreenCameraManager());
        break;
      default:
        return null;
    }
  }
}
