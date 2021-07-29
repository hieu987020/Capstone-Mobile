import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(),
      drawer: AdminNavigator(
        size: size,
        selectedIndex: 'Manager',
      ),
      floatingActionButton: AddFloatingButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenManagerCreate()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                HeaderWithSearchBox(size),
                TitleWithMoreBtn(
                  title: 'List Manager',
                  model: 'manager',
                ),
                BlocBuilder<UserBloc, UserState>(
                  // ignore: missing_return
                  builder: (context, state) {
                    if (state is UserLoaded) {
                      return ManagerContent();
                    } else if (state is UserError) {
                      return FailureStateWidget();
                    } else if (state is UserLoading) {
                      return LoadingWidget();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ManagerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<User> users;
    var state = BlocProvider.of<UserBloc>(context).state;
    if (state is UserLoaded) {
      users = state.users;
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: FutureBuilder<List<User>>(
          initialData: users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> userLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: userLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'manager',
                    imageURL: userLst[index].imageURL,
                    title: userLst[index].userName,
                    sub: userLst[index].fullName,
                    status: userLst[index].status,
                    navigationField: userLst[index].userName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenManagerDetail()),
                      );
                      BlocProvider.of<UserDetailBloc>(context)
                          .add(UserDetailFetchEvent(userLst[index].userName));
                    },
                  );
                },
              );
            } else if (snapshot.data == null) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return Text("No Record: ${snapshot.error}");
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
