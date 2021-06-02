import 'package:flutter/material.dart';

class NavigatorButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('CFFA System'),
          ),
          ListTile(
            title: Text('Dashboard'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
          ListTile(
            title: Text('Store'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/store");
            },
          ),
          ListTile(
            title: Text('Manager'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/manager");
            },
          ),
          ListTile(
            title: Text('Product'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/product");
            },
          ),
          ListTile(
            title: Text('Camera'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/camera");
            },
          ),
        ],
      ),
    );
  }
}
