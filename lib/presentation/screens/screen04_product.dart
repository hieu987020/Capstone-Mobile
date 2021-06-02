import 'package:capstone/business_logic/blocs/blocs.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Product'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: NavigatorButton(),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final users = state.users;

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(users[index].fullName),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[index].imageURL),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
