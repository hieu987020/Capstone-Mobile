import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        body: const WebView(
          initialUrl: 'https://datastudio.google.com/s/sn0Uktbk6Wg',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
