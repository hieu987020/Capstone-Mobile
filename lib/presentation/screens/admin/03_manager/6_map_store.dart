import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerMapStore extends StatefulWidget {
  @override
  _ScreenManagerMapStoreState createState() => _ScreenManagerMapStoreState();
}

class _ScreenManagerMapStoreState extends State<ScreenManagerMapStore> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  // TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "storeName";
  // String selectedValueStatus = "";

  @override
  void initState() {
    // selectedValueStatus = 'All';
    _valueSearch.value = TextEditingValue(text: '');
    // _statusId.value = TextEditingValue(text: '0');
    super.initState();
  }

  Future<Null> _onRefresh(BuildContext context) async {
    callApi();
  }

  callApi() {
    BlocProvider.of<StoreBloc>(context).add(StoreFetchEvent(
      searchValue: _valueSearch.text,
      searchField: "storeName",
      fetchNext: 100,
      pageNum: 0,
      statusId: 3,
      cityId: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async => _onRefresh(context),
      child: Scaffold(
        appBar: buildNormalAppbar('Choose Store'),
        body: MyScrollView(
          listWidget: [
            SearchBox(
              onSubmitted: (value) {
                setState(() {
                  _valueSearch.value = TextEditingValue(text: value);
                });
                FocusScope.of(context).requestFocus(new FocusNode());
                callApi();
              },
              onChanged: (value) {
                setState(() {
                  _valueSearch.value = TextEditingValue(text: value);
                });
              },
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                callApi();
              },
            ),
            TitleWithNothing(
              title: 'List Pending Stores',
            ),
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state is StoreLoaded) {
                  return UserLoadStoreContent();
                } else if (state is StoreError) {
                  return FailureStateWidget();
                } else if (state is StoreLoading) {
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
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

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
              return ErrorRecordWidget();
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
