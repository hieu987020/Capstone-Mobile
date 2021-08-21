import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductDetailManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildNormalAppbar('Product Detail'),
      body: MyScrollView(
        listWidget: [
          ProductDetailHeaderM(),
          ProductDetailInformationM(size: size),
          SizedBox(height: 10),
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              if (state is ProductDetailLoaded) {
                if (state.stores != null) {
                  return TitleWithNothing(title: "Store");
                }
              }
              return SizedBox(height: 0);
            },
          ),
          ProductDetailFooterM(),
        ],
      ),
    );
  }
}

class ProductDetailHeaderM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return LoadingContainer();
        } else if (state is ProductDetailLoaded) {
          var product = state.product;
          return DetailHeaderContainer(
            imageURL: product.imageUrl,
            title: product.productName,
            status: product.statusName,
          );
        } else if (state is ProductDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProductDetailInformationM extends StatelessWidget {
  final Size size;
  ProductDetailInformationM({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoading) {
          return LoadingContainer();
        } else if (state is ProductDetailLoaded) {
          var product = state.product;
          return Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DescriptionFieldContainer(
                  fieldName: 'Description',
                  fieldValue: product.description,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Created Time',
                  fieldValue: product.createdTime,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Updated Time',
                  fieldValue: product.updatedTime,
                ),
                (product.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailDivider(size: size),
                (product.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailFieldContainer(
                        fieldName: 'Reason Inactive',
                        fieldValue: product.reasonInactive,
                      ),
                DetailDivider(size: size),
              ],
            ),
          );
        } else if (state is ProductDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class ProductDetailFooterM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoaded) {
          var stores = state.stores;
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
                        return ObjectListInkWell(
                          model: 'store',
                          imageURL: storeLst[index].imageUrl,
                          title: storeLst[index].storeName,
                          sub: storeLst[index].managerUsername ?? "-",
                          status: storeLst[index].statusName,
                          navigationField: storeLst[index].storeId,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => ScreenStoreDetail()),
                            // );
                            // BlocProvider.of<StoreDetailBloc>(context).add(
                            //     StoreDetailFetchEvent(storeLst[index].storeId));
                          },
                        );
                      },
                    );
                  } else if (snapshot.data == null) {
                    return Text("");
                  } else if (snapshot.hasError) {
                    return ErrorRecordWidget();
                  }
                  return LoadingWidget();
                },
              ),
            ),
          );
        } else if (state is ProductDetailError) {
          return FailureStateWidget();
        } else if (state is ProductDetailLoading) {
          return LoadingWidget();
        }
        return LoadingWidget();
      },
    );
  }
}
