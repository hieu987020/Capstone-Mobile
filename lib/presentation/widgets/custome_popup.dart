import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> outApp(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('App Message'),
        content: Text("Are you sure to out App"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
