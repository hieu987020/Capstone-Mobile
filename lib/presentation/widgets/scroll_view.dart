import 'package:flutter/material.dart';

class MyScrollView extends StatelessWidget {
  final List<Widget> listWidget;
  MyScrollView({this.listWidget});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: SingleChildScrollView(
        child: SafeArea(
          minimum: EdgeInsets.only(bottom: 200),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: listWidget,
            ),
          ),
        ),
      ),
    );
  }
}
