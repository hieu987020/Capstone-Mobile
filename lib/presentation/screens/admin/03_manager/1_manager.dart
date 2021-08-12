import 'dart:async';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManager extends StatefulWidget {
  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "fullName";
  String selectedValueStatus = "";

  @override
  void initState() {
    selectedValueStatus = 'All';
    _valueSearch.value = TextEditingValue(text: '');
    _statusId.value = TextEditingValue(text: '0');
    super.initState();
  }

  Future<Null> _onRefresh(BuildContext context) async {
    callApi();
  }

  callApi() {
    BlocProvider.of<UserBloc>(context).add(UserFetchEvent(
      searchValue: _valueSearch.text,
      searchField: searchField,
      fetchNext: 100,
      pageNum: 0,
      statusId: int.parse(_statusId.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => outApp(context),
      child: RefreshIndicator(
        onRefresh: () async => _onRefresh(context),
        child: Scaffold(
          appBar: buildAppBar(),
          drawer: AdminNavigator(size: size, selectedIndex: 'Manager'),
          floatingActionButton: AddFloatingButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenManagerCreate()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                minimum: EdgeInsets.only(bottom: 10),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HeaderWithSearchBox(
                        size: size,
                        title: "Hi Admin",
                        valueSearch: _valueSearch,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            TitleWithCustomUnderline(text: "Manager"),
                            Spacer(),
                            StatusDropdown(
                              model: 'manager',
                              defaultValue: selectedValueStatus,
                              controller: _statusId,
                              callFunc: () {
                                callApi();
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoaded) {
                            return ManagerContent(
                              statusId: int.parse(_statusId.text),
                              valueSearch: _valueSearch.text,
                              users: state.users,
                            );
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ManagerContent extends StatefulWidget {
  final String valueSearch;
  final int statusId;
  final List<User> users;
  ManagerContent(
      {@required this.valueSearch, @required this.statusId, this.users});
  @override
  _ManagerContentState createState() =>
      _ManagerContentState(valueSearch, statusId, users);
}

class _ManagerContentState extends State<ManagerContent> {
  final String _valueSearch;
  final int _statusId;
  final List<User> _users;
  _ManagerContentState(this._valueSearch, this._statusId, this._users);

  final _scrollController = ScrollController();
  bool isLoading = false;
  int fetchNext = 7;
  int pageCount = 1;
  List<User> userList;
  List<String> items = new List.generate(100, (index) => 'Hello $index');

  @override
  void initState() {
    super.initState();
    _scrollController..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500) {
      setState(() {
        // items.addAll(new List.generate(42, (index) => 'Inserted $index'));
        // if (state is UserLoaded) {
        //   users = state.users;
        //   if (state.reachMax) {
        //     print("Max roi");
        //   } else {
        //     print("Chua Max");
        //     BlocProvider.of<UserBloc>(context).add(UserFetchEvent(
        //       searchValue: _valueSearch,
        //       searchField: "fullname",
        //       fetchNext: fetchNext,
        //       pageNum: 3,
        //       statusId: _statusId,
        //       users: users,
        //     ));
        //   }
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<User>>(
          initialData: _users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                // controller: _scrollController,
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  // return index == 50 ? BottomLoader() : Text(items[index]);
                  return ObjectListInkWell3(
                    model: 'manager',
                    imageURL: _users[index].imageURL,
                    title: _users[index].userName,
                    sub: _users[index].fullName,
                    three: _users[index].storeName ?? "-",
                    status: _users[index].status,
                    navigationField: _users[index].userName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenManagerDetail()),
                      );
                      BlocProvider.of<UserDetailBloc>(context)
                          .add(UserDetailFetchEvent(_users[index].userName));
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

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
