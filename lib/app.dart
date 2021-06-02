import 'package:capstone/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/blocs/blocs.dart';

class App extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UsersBloc>(
          create: (context) => UsersBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGenerateRoute,
        // home: ScreenManager(),
        // routes: {
        //   Routes.manager: (context) => ScreenManager(),
        //   Routes.store: (context) => ScreenStore(),
        //   Routes.product: (context) => ScreenProduct(),
        //   Routes.camera: (context) => ScreenCamera(),
        //   Routes.dashboard: (context) => ScreenDashboard(),
        // },
      ),
    );
  }
}
