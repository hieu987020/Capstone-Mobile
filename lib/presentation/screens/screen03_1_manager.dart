import 'package:capstone/business_logic/blocs/blocs.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UsersBloc usersBloc = BlocProvider.of<UsersBloc>(context);
    usersBloc.add(InitEvent());
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Manager'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      drawer: NavigatorButton(),
      body: Container(
        child: Column(
          children: [
            ManagerCardHeader('List Manager'),
            BlocBuilder<UsersBloc, UsersState>(
              bloc: usersBloc,
              builder: (context, state) {
                if (state is LoadingState) {
                  return CircularProgressIndicator();
                } else if (state is LoadedState) {
                  return Expanded(
                    child: SizedBox(
                      child: FutureBuilder<List<Users>>(
                        initialData: state.users,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Users> userLst = snapshot.data;
                            return ListView.builder(
                              itemCount: userLst.length,
                              itemBuilder: (context, index) {
                                return Theme(
                                  data: ThemeData(
                                    splashColor: Colors.blue,
                                  ),
                                  child: ListTile(
                                    leading: ManagerCardAvatar(
                                        userLst[index].imageURL),
                                    title: ManagerText(userLst[index].userName),
                                    subtitle:
                                        StoreText(userLst[index].storeName),
                                    trailing: StatusText(userLst[index].status),
                                    onTap: () {},
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  );
                } else if (state is ErrorState) {
                  return Text("error");
                }
                return Text("cac");
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
