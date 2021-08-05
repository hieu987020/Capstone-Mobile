import 'package:capstone/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/bloc/bloc.dart';
import 'presentation/widgets/widgets.dart';

class App extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
//! Login
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
//! User
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
        BlocProvider<UserSearchBloc>(
          create: (context) => UserSearchBloc(),
        ),
        BlocProvider<UserDetailBloc>(
          create: (context) => UserDetailBloc(),
        ),
        BlocProvider<UserCreateBloc>(
          create: (context) => UserCreateBloc(),
        ),
        BlocProvider<UserUpdateBloc>(
          create: (context) => UserUpdateBloc(),
        ),
        BlocProvider<UserUpdateImageBloc>(
          create: (context) => UserUpdateImageBloc(),
        ),
        BlocProvider<UserUpdateInsideBloc>(
          create: (context) => UserUpdateInsideBloc(),
        ),
        BlocProvider<UserInactiveBloc>(
          create: (context) => UserInactiveBloc(),
        ),
//! Store
        BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(),
        ),
        BlocProvider<StoreDetailBloc>(
          create: (context) => StoreDetailBloc(),
        ),
        BlocProvider<StoreCreateBloc>(
          create: (context) => StoreCreateBloc(),
        ),
        BlocProvider<StoreUpdateBloc>(
          create: (context) => StoreUpdateBloc(),
        ),
        BlocProvider<StoreUpdateImageBloc>(
          create: (context) => StoreUpdateImageBloc(),
        ),
        BlocProvider<StoreUpdateInsideBloc>(
          create: (context) => StoreUpdateInsideBloc(),
        ),
//! Product
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(),
        ),
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(),
        ),
        BlocProvider<ProductCreateBloc>(
          create: (context) => ProductCreateBloc(),
        ),
        BlocProvider<ProductUpdateBloc>(
          create: (context) => ProductUpdateBloc(),
        ),
        BlocProvider<ProductUpdateImageBloc>(
          create: (context) => ProductUpdateImageBloc(),
        ),
//! Category
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
//! Camera
        BlocProvider<CameraBloc>(
          create: (context) => CameraBloc(),
        ),
        BlocProvider<CameraDetailBloc>(
          create: (context) => CameraDetailBloc(),
        ),
        BlocProvider<CameraCreateBloc>(
          create: (context) => CameraCreateBloc(),
        ),
        BlocProvider<CameraUpdateBloc>(
          create: (context) => CameraUpdateBloc(),
        ),
        BlocProvider<CameraUpdateImageBloc>(
          create: (context) => CameraUpdateImageBloc(),
        ),
        BlocProvider<CameraUpdateInsideBloc>(
          create: (context) => CameraUpdateInsideBloc(),
        ),
//! Shelf
        BlocProvider<ShelfBloc>(
          create: (context) => ShelfBloc(),
        ),
        BlocProvider<ShelfDetailBloc>(
          create: (context) => ShelfDetailBloc(),
        ),
        BlocProvider<ShelfUpdateInsideBloc>(
          create: (context) => ShelfUpdateInsideBloc(),
        ),
        BlocProvider<ShelfCreateBloc>(
          create: (context) => ShelfCreateBloc(),
        ),
//! Stack
        BlocProvider<StackBloc>(
          create: (context) => StackBloc(),
        ),
        BlocProvider<StackDetailBloc>(
          create: (context) => StackDetailBloc(),
        ),
        BlocProvider<StackUpdateInsideBloc>(
          create: (context) => StackUpdateInsideBloc(),
        ),
        BlocProvider<CityBloc>(
          create: (context) => CityBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CFFE App',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
