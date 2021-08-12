import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategory extends StatefulWidget {
  @override
  _ScreenCategoryState createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "categoryName";
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
    BlocProvider.of<CategoryBloc>(context).add(CategoryFetchEvent(
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
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: AdminNavigator(
          size: size,
          selectedIndex: 'Category',
        ),
        floatingActionButton: AddFloatingButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScreenCategoryCreate()));
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
                  TitleWithCustomUnderline(text: "Category"),
                  Spacer(),
                  StatusDropdown(
                    model: 'category',
                    defaultValue: selectedValueStatus,
                    controller: _statusId,
                    callFunc: () {
                      callApi();
                    },
                  ),
                ],
              ),
            ),
            BlocBuilder<CategoryBloc, CategoryState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is CategoryLoaded) {
                  return CategoryContent();
                } else if (state is CategoryError) {
                  return FailureStateWidget();
                } else if (state is CategoryLoading) {
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

class CategoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Category> categories;
    var state = BlocProvider.of<CategoryBloc>(context).state;
    if (state is CategoryLoaded) {
      categories = state.categories;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Category>>(
          initialData: categories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Category> lst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return CategoryListInkWell(
                    model: 'camera',
                    title: lst[index].categoryName,
                    status: lst[index].statusName,
                    navigationField: lst[index].categoryName,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenCategoryDetail()),
                      );
                      BlocProvider.of<CategoryDetailBloc>(context)
                          .add(CategoryDetailFetchEvent(lst[index].categoryId));
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
