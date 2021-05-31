import 'package:flutter/material.dart';
import 'package:capstone/widgets/widgets.dart';
import 'package:capstone/repositories/repositories.dart';
import 'package:capstone/models/models.dart';

class ScreenManager extends StatelessWidget {
  static const String routeName = '/manager';
  final UserRepository userRepo;
  ScreenManager(this.userRepo);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Manager'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: NavigatorButton(),
      body: Column(
        children: [
          ManagerCardHeader('List Manager'),
          Expanded(
            child: SizedBox(
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
                          userLst[index].storeName,
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
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
