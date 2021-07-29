import 'package:capstone/business_logic/utility/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(App());
}
