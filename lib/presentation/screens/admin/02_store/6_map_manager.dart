import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreMapManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserBloc>(context)
        .add(UserFetchEvent(StatusIntBase.Pending));
    return Scaffold(
      appBar: buildNormalAppbar('Choose Manager'),
      body: BlocListener<StoreUpdateInsideBloc, StoreUpdateInsideState>(
        listener: (context, state) {
          if (state is StoreUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is StoreUpdateInsideError) {
            _storeMapManagerError(context, state);
          } else if (state is StoreUpdateInsideLoaded) {
            _storeMapManagerLoaded(context);
          }
        },
        child: MyScrollView(
          listWidget: [
            SizedBox(height: 10),
            TitleWithNothing(
              title: 'List Pending Managers',
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
      ),
    );
  }
}

_storeConfirmManager(BuildContext context, String userId) {
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
              String storeId;
              var storeDetailState =
                  BlocProvider.of<StoreDetailBloc>(context).state;
              if (storeDetailState is StoreDetailLoaded) {
                storeId = storeDetailState.store.storeId;
              }
              BlocProvider.of<StoreUpdateInsideBloc>(context)
                  .add(StoreMapManagerEvent(storeId, userId, 1));
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

_storeMapManagerError(BuildContext context, StoreUpdateInsideError state) {
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
                      _storeConfirmManager(context, userLst[index].userId);
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
