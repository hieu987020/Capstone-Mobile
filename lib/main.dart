import 'package:flutter/material.dart';
import 'package:capstone/repositories/repositories.dart';
import 'app.dart';

void main() {
  final CommonRepository commonRepository = new CommonRepository();

  runApp(App(commonRepository));
}
