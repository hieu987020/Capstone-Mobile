import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerMapStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    BlocProvider.of<StoreBloc>(context)
        .add(StoreFetchEvent(StatusIntBase.Pending));
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Choose store'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<UserUpdateInsideBloc, UserUpdateInsideState>(
        listener: (context, state) {
          if (state is UserUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is UserUpdateInsideError) {
            _userMapStoreError(context, state);
          } else if (state is UserUpdateInsideLoaded) {
            _userMapStoreLoaded(context);
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TitleWithNothing(
                    title: 'List Stores',
                  ),
                  BlocBuilder<StoreBloc, StoreState>(
                    // ignore: missing_return
                    builder: (context, state) {
                      if (state is StoreLoaded) {
                        return UserLoadStoreContent();
                      } else if (state is StoreError) {
                        return FailureStateWidget();
                      } else if (state is StoreLoading) {
                        return LoadingWidget();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: todo
//TODO Stuff
_userConfirmStore(BuildContext context, String storeId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Store'),
        content: Text('Are you sure to add this store?'),
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
              BlocProvider.of<UserUpdateInsideBloc>(context)
                  .add(UserMapStoreEvent(storeId, managerId, 1));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_userMapStoreLoaded(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

_userMapStoreError(BuildContext context, UserUpdateInsideError state) {
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

// ignore: todo
//TODO View
class UserLoadStoreBoldText extends StatelessWidget {
  final String _text;
  UserLoadStoreBoldText(this._text);
  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      return Container(
        child: new Text(
          _text,
          style: TextStyle(
            color: Color.fromRGBO(69, 75, 102, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Text("");
  }
}

class UserLoadStoreNormalText extends StatelessWidget {
  final String _text;
  UserLoadStoreNormalText(this._text);
  @override
  Widget build(BuildContext context) {
    if (this._text != null) {
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: new Text(
          _text,
          style: TextStyle(
            color: Color.fromRGBO(24, 34, 76, 1),
            fontSize: 15,
          ),
        ),
      );
    }
    return Text("");
  }
}

class UserLoadStoreHeader extends StatelessWidget {
  final String _text;
  UserLoadStoreHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScreenHeaderText(_text),
      ],
    );
  }
}

// class UserLoadStoreContent extends StatefulWidget {
//   @override
//   _UserLoadStoreContentState createState() => _UserLoadStoreContentState();
// }

// class _UserLoadStoreContentState extends State<UserLoadStoreContent> {
//   @override
//   Widget build(BuildContext context) {
//     List<Store> stores;
//     var state = BlocProvider.of<StoreBloc>(context).state;
//     if (state is StoreLoaded) {
//       stores = state.stores;
//     }
//     Future<Null> _onStoreRefresh(BuildContext context) async {
//       BlocProvider.of<StoreBloc>(context)
//           .add(StoreFetchEvent(StatusIntBase.Pending));
//       setState(() {
//         stores.clear();
//       });
//     }

//     return RefreshIndicator(
//       onRefresh: () async {
//         _onStoreRefresh(context);
//       },
//       child: Container(
//         margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
//         child: FutureBuilder<List<Store>>(
//           initialData: stores,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Store> storeLst = snapshot.data;
//               return ListView.builder(
//                 itemCount: storeLst.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(storeLst[index].imageUrl),
//                       backgroundColor: Colors.white,
//                     ),
//                     title: UserLoadStoreBoldText(storeLst[index].storeName),
//                     subtitle: UserLoadStoreNormalText(
//                         storeLst[index].managerUsername),
//                     trailing: StatusText(storeLst[index].statusName),
//                     onTap: () {
//                       _userConfirmStore(context, storeLst[index].storeId);
//                     },
//                   );
//                 },
//               );
//             } else if (snapshot.data == null) {
//               return NoRecordWidget();
//             } else if (snapshot.hasError) {
//               return Text("No Record: ${snapshot.error}");
//             }
//             return LoadingWidget();
//           },
//         ),
//       ),
//     );
//   }
// }

class UserLoadStoreContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> stores;
    var state = BlocProvider.of<StoreBloc>(context).state;
    if (state is StoreLoaded) {
      stores = state.stores;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: FutureBuilder<List<Store>>(
          initialData: stores,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store> storeLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'store',
                    imageURL: storeLst[index].imageUrl,
                    title: storeLst[index].storeName,
                    sub: storeLst[index].address,
                    status: storeLst[index].statusName,
                    navigationField: storeLst[index].storeId,
                    onTap: () {
                      _userConfirmStore(context, storeLst[index].storeId);
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
