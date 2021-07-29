import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreMapManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    //Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    BlocProvider.of<UserBloc>(context)
        .add(UserFetchEvent(StatusIntBase.Pending));
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Store Map Manager'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          TitleWithNothing(
            title: 'List Managers',
          ),
          BlocBuilder<UserBloc, UserState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is UserLoaded) {
                return MapManagerContent();
              } else if (state is UserError) {
                return FailureStateWidget();
              } else if (state is UserLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}

_storeConfirmManager(BuildContext context, String userName) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Manager'),
        content: Text('Are you sure to map this manager'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String managerId;
              var userDetailState =
                  BlocProvider.of<UserDetailBloc>(context).state;
              if (userDetailState is UserDetailLoaded) {
                managerId = userDetailState.user.userId;
              }
              // BlocProvider.of<UserUpdateInsideBloc>(context)
              //     .add(UserMapStoreEvent(storeId, managerId, 1));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_storeMapManagerLoaded(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

_storeMapManagerError(BuildContext context, UserUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Store Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

class MapManagerContent extends StatelessWidget {
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
                      _storeConfirmManager(context, userLst[index].userName);
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
