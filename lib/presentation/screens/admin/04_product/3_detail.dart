import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Product Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          ProductMenu(),
        ],
      ),
      body: BlocListener<ProductUpdateInsideBloc, ProductUpdateInsideState>(
        listener: (context, state) {
          if (state is ProductUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is ProductUpdateInsideError) {
            _productUpdateInsideError(context, state);
          } else if (state is ProductUpdateInsideLoaded) {
            _productUpdateInsideLoaded(context, state);
          }
        },
        child: MyScrollView(
          listWidget: [
            ProductDetailHeader(),
            ProductDetailInformation(size: size),
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
            ProductDetailFooter(),
          ],
        ),
      ),
    );
  }
}

_productUpdateInsideLoaded(
    BuildContext context, ProductUpdateInsideLoaded state) {
  String productId;
  var userDetailState = BlocProvider.of<ProductDetailBloc>(context).state;
  if (userDetailState is ProductDetailLoaded) {
    productId = userDetailState.product.productId;
  }
  BlocProvider.of<ProductDetailBloc>(context)
      .add(ProductDetailFetchEvent(productId));
  Navigator.pop(context);
}

_productUpdateInsideError(
    BuildContext context, ProductUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('App Message'),
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

_productChangeStatusDialog(BuildContext context, int statusId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change to Active'),
        content: Text('The status will change to Active, are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String productId;
              var state = BlocProvider.of<ProductDetailBloc>(context).state;
              if (state is ProductDetailLoaded) {
                productId = state.product.productId;
              }
              BlocProvider.of<ProductUpdateInsideBloc>(context)
                  .add(ProductChangeStatus(productId, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class ProductMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenProductUpdateInformation()));
          break;
        case 'Change Image':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenProductUpdateImage()));
          break;
        case 'Change To Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenProductInactive()));
          break;
        case 'Change To Active':
          _productChangeStatusDialog(context, StatusIntBase.Active);
          break;
      }
    }

    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoaded) {
          if (state.product.statusName == StatusStringBase.Inactive) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
                  'Change To Active'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.product.statusName == StatusStringBase.Active) {
            if (state.stores != null) {
              return PopupMenuButton<String>(
                onSelected: _handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Update Information',
                    'Change Image',
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              );
            } else {
              return PopupMenuButton<String>(
                onSelected: _handleClick,
                itemBuilder: (BuildContext context) {
                  return {
                    'Update Information',
                    'Change Image',
                    'Change To Inactive'
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              );
            }
          }
        }
        return PopupMenuButton<String>(
          onSelected: _handleClick,
          itemBuilder: (BuildContext context) {
            return {''}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      },
    );
  }
}

class ProductDetailHeader extends StatelessWidget {
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

class ProductDetailInformation extends StatelessWidget {
  final Size size;
  ProductDetailInformation({this.size});
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
                DetailFieldContainer(
                  fieldName: 'Category',
                  fieldValue: "Ipod",
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
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
        return LoadingContainer();
      },
    );
  }
}

class ProductDetailFooter extends StatelessWidget {
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
                          status: "",
                          navigationField: storeLst[index].storeId,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenStoreDetail()),
                            );
                            BlocProvider.of<StoreDetailBloc>(context).add(
                                StoreDetailFetchEvent(storeLst[index].storeId));
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
