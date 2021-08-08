import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => outApp(context),
      child: Scaffold(
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
        body: MyScrollView(
          listWidget: [
            HeaderWithSearchBox(
              size: size,
              title: "Hi Admin",
            ),
            TitleWithMoreBtn(
              title: 'Manager',
              model: 'manager',
              defaultStatus: StatusStringBase.All,
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return ManagerContent();
                } else if (state is UserError) {
                  return FailureStateWidget();
                } else if (state is UserLoading) {
                  return LoadingWidget();
                }
                return LoadingWidget();
              },
            ),
          ],
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
        padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                  return ObjectListInkWell3(
                    model: 'manager',
                    imageURL: userLst[index].imageURL,
                    title: userLst[index].userName,
                    sub: userLst[index].fullName,
                    three: userLst[index].storeName ?? "-",
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
              return ErrorRecordWidget();
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
