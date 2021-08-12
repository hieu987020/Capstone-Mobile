import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStore extends StatefulWidget {
  @override
  _ScreenStoreState createState() => _ScreenStoreState();
}

class _ScreenStoreState extends State<ScreenStore> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "storeName";
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
    BlocProvider.of<StoreBloc>(context).add(StoreFetchEvent(
      searchValue: _valueSearch.text,
      searchField: "storeName",
      fetchNext: 100,
      pageNum: 0,
      statusId: int.parse(_statusId.text),
      cityId: 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: RefreshIndicator(
        onRefresh: () async {
          _onRefresh(context);
        },
        child: Scaffold(
          appBar: buildAppBar(),
          drawer: AdminNavigator(
            size: size,
            selectedIndex: 'Store',
          ),
          floatingActionButton: AddFloatingButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScreenStoreCreate()));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniCenterFloat,
          body: MyScrollView(
            listWidget: [
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
                    TitleWithCustomUnderline(text: "Store"),
                    Spacer(),
                    StatusDropdown(
                      model: 'store',
                      defaultValue: selectedValueStatus,
                      controller: _statusId,
                      callFunc: () {
                        callApi();
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state is StoreLoaded) {
                    return StoreContent();
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
      ),
    );
  }
}

class StoreContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Store> stores;
    var state = BlocProvider.of<StoreBloc>(context).state;
    if (state is StoreLoaded) {
      stores = state.stores;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
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
                  return ObjectListInkWell3(
                    model: 'store',
                    imageURL: storeLst[index].imageUrl,
                    title: storeLst[index].storeName,
                    sub: storeLst[index].address,
                    three: storeLst[index].managerUsername ?? "-",
                    status: storeLst[index].statusName,
                    navigationField: storeLst[index].storeId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenStoreDetail()),
                      );
                      BlocProvider.of<StoreDetailBloc>(context)
                          .add(StoreDetailFetchEvent(storeLst[index].storeId));
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
