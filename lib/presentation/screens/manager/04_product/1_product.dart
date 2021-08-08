import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Product',
        ),
        body: MyScrollView(
          listWidget: [
            HeaderWithSearchBox(
              size: size,
              title: "Hi Manager",
            ),
            TitleWithMoreBtn(
              title: 'Product',
              model: 'product',
              defaultStatus: StatusStringBase.All,
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return ProductContentM();
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
    );
  }
}

class ProductContentM extends StatelessWidget {
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
                            builder: (context) => ScreenProductDetailManager()),
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
