import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelf extends StatefulWidget {
  @override
  _ScreenShelfState createState() => _ScreenShelfState();
}

class _ScreenShelfState extends State<ScreenShelf> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  TextEditingController _statusId = TextEditingController(text: "");
  // String searchField = "fullName";
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
    BlocProvider.of<ShelfBloc>(context).add(ShelfFetchEvent(
      storeId: "",
      shelfName: _valueSearch.text,
      fetchNext: 100,
      pageNum: 0,
      statusId: int.parse(_statusId.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: RefreshIndicator(
        onRefresh: () async => _onRefresh(context),
        child: Scaffold(
          appBar: buildAppBar(),
          drawer: ManagerNavigator(
            size: size,
            selectedIndex: 'Shelf',
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenShelfCreate()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: MyScrollView(
            listWidget: [
              HeaderWithSearchBox(
                size: size,
                title: "Hi Manager",
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
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  if (state is LoginManagerLoaded) {
                    return Padding(
                      padding: EdgeInsets.only(left: kDefaultPadding / 2),
                      child: Container(
                        child: Text(
                          state.loginModel.storeName,
                          style: TextStyle(
                            fontSize: 20,
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: <Widget>[
                    TitleWithCustomUnderline(text: "Shelf"),
                    Spacer(),
                    StatusDropdown(
                      model: 'shelf',
                      defaultValue: selectedValueStatus,
                      controller: _statusId,
                      callFunc: () {
                        callApi();
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<ShelfBloc, ShelfState>(
                builder: (context, state) {
                  if (state is ShelfLoaded) {
                    return ShelfContent();
                  } else if (state is ShelfError) {
                    return FailureStateWidget();
                  } else if (state is ShelfLoading) {
                    return LoadingWidget();
                  }
                  return LoadingWidget();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShelfContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Shelf> shelves;
    var state = BlocProvider.of<ShelfBloc>(context).state;
    if (state is ShelfLoaded) {
      shelves = state.shelves;
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Shelf>>(
          initialData: shelves,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Shelf> lst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return ShelfListInkWell(
                    model: 'manager',
                    title: lst[index].shelfName,
                    sub: lst[index].description ?? "",
                    three: "Number stacks: " +
                            lst[index].numberOfStack.toString() ??
                        "",
                    status: lst[index].statusName,
                    navigationField: lst[index].shelfId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenShelfDetail(
                                  shelfId: lst[index].shelfId,
                                )),
                      );
                      BlocProvider.of<ShelfDetailBloc>(context)
                          .add(ShelfDetailFetchEvent(lst[index].shelfId));
                      BlocProvider.of<StackBloc>(context)
                          .add(StackFetchEvent(lst[index].shelfId));
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
