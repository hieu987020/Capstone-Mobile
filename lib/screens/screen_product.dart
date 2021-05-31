import 'package:capstone/models/models.dart';
import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';
import 'package:capstone/repositories/repositories.dart';

class ScreenProduct extends StatelessWidget {
  static const String routeName = '/product';
  final UserRepository userRepo;
  ScreenProduct(this.userRepo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Product'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: NavigatorButton(),
      body: Container(
        child: FutureBuilder<List<Users>>(
          future: userRepo.userApiClient.fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Users> userLst = snapshot.data;
              return ListView.builder(
                itemCount: userLst.length,
                itemBuilder: (context, index) {
                  return ManagerCard(
                    userLst[index].imageURL,
                    userLst[index].userName,
                    userLst[index].status,
                    userLst[index].status,
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
