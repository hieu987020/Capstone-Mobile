import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    leading: Builder(
      builder: (context) => // Ensure Scaffold is in context
          IconButton(
              icon: SvgPicture.asset(
                "assets/icons/menu.svg",
              ),
              onPressed: () => Scaffold.of(context).openDrawer()),
    ),
  );
}

AppBar buildNormalAppbar(String title) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: kPrimaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
