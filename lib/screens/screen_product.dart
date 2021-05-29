import 'package:capstone/models/models.dart';
import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';

class ScreenProduct extends StatelessWidget {
  static const String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Product'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: NavigatorButton(),
      body: Container(
        child: FutureBuilder<dynamic>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ManagerCard(
                snapshot.data.imageURL,
                snapshot.data.managerName,
                snapshot.data.managerName,
                snapshot.data.status,
              );
            } else {
              return Center(
                child: Text('deo co data'),
              );
            }
          },
        ),
      ),
    );
  }
}
