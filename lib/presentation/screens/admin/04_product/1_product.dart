import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProduct extends StatefulWidget {
  @override
  _ScreenProductState createState() => _ScreenProductState();
}

class _ScreenProductState extends State<ScreenProduct> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "productName";
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
    BlocProvider.of<ProductBloc>(context).add(ProductFetchEvent(
      searchValue: _valueSearch.text,
      searchField: searchField,
      fetchNext: 100,
      pageNum: 0,
      categoryId: 0,
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
          drawer: AdminNavigator(
            size: size,
            selectedIndex: 'Product',
          ),
          floatingActionButton: AddFloatingButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenProductCreate()));
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
                    TitleWithCustomUnderline(text: "Product"),
                    Spacer(),
                    StatusDropdown(
                      model: 'product',
                      defaultValue: selectedValueStatus,
                      controller: _statusId,
                      callFunc: () {
                        callApi();
                      },
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoaded) {
                    return ProductContent();
                  } else if (state is ProductError) {
                    return FailureStateWidget();
                  } else if (state is ProductLoading) {
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

class ProductContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Product> products;
    var state = BlocProvider.of<ProductBloc>(context).state;
    if (state is ProductLoaded) {
      products = state.products;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Product>>(
          initialData: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> productLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productLst.length,
                itemBuilder: (context, index) {
                  List<Category> listCate = productLst[index].categories;
                  String cateString = "";
                  listCate.forEach((element) {
                    cateString += element.categoryName;
                    if (listCate.last.categoryId == element.categoryId) {
                      cateString += ".";
                    } else {
                      cateString += ", ";
                    }
                  });
                  return ObjectListInkWell3(
                    model: 'product',
                    imageURL: productLst[index].imageUrl,
                    title: productLst[index].productName,
                    sub: productLst[index].description,
                    three: cateString,
                    status: productLst[index].statusName,
                    navigationField: productLst[index].productId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenProductDetail()),
                      );
                      BlocProvider.of<ProductDetailBloc>(context).add(
                          ProductDetailFetchEvent(productLst[index].productId));
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
