import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategoryDetailManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildNormalAppbar('Category Detail'),
      body: MyScrollView(
        listWidget: [
          CategoryDetailInformationM(size: size),
          SizedBox(height: 10),
          TitleWithNothing(title: "Product"),
          CategoryFooterM(),
        ],
      ),
    );
  }
}

class CategoryDetailInformationM extends StatelessWidget {
  final Size size;
  CategoryDetailInformationM({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
      builder: (context, state) {
        if (state is CategoryDetailLoading) {
          return LoadingContainer();
        } else if (state is CategoryDetailLoaded) {
          var cate = state.category;
          return Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailFieldContainer(
                  fieldName: 'Category Name',
                  fieldValue: cate.categoryName,
                ),
                DetailDivider(size: size),
                DetailFieldContainerStatus(
                  fieldName: 'Status',
                  fieldValue: cate.statusName,
                ),
                DetailDivider(size: size),
              ],
            ),
          );
        } else if (state is CategoryDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}

class CategoryFooterM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
      builder: (context, state) {
        if (state is CategoryDetailLoading) {
          return LoadingContainer();
        } else if (state is CategoryDetailLoaded) {
          var products = state.products;

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
                        return ObjectListInkWell(
                          model: 'product',
                          imageURL: productLst[index].imageUrl,
                          title: productLst[index].productName,
                          sub: productLst[index].description,
                          status: productLst[index].statusName,
                          navigationField: productLst[index].productId,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ScreenProductDetailManager()),
                            );
                            BlocProvider.of<ProductDetailBloc>(context).add(
                                ProductDetailFetchEvent(
                                    productLst[index].productId));
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
        } else if (state is CategoryDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}
