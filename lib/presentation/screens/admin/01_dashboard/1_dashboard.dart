import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/appbar.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenAdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    BlocProvider.of<CityBloc>(context).add(CityFetchEvent());
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AdminNavigator(
        size: size,
        selectedIndex: 'Dashboard',
      ),
      body: const WebView(
        initialUrl: 'https://datastudio.google.com/s/sn0Uktbk6Wg',
        javascriptMode: JavascriptMode.unrestricted,
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       HeaderWithSearchBox(size),
      //       TitleWithMoreBtn(
      //         title: 'Dashboard',
      //       ),
      //       const WebView(
      //         initialUrl: 'https://flutter.io',
      //         javascriptMode: JavascriptMode.unrestricted,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
