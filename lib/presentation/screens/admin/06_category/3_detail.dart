import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCategoryDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Category Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          CategoryMenu(),
        ],
      ),
      body: BlocListener<CategoryUpdateInsideBloc, CategoryUpdateInsideState>(
        listener: (context, state) {
          if (state is CategoryUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is CategoryUpdateInsideError) {
            _categoryUpdateInsideError(context, state);
          } else if (state is CategoryUpdateInsideLoaded) {
            _categoryUpdateInsideLoaded(context, state);
          }
        },
        child: MyScrollView(
          listWidget: [
            CategoryDetailInformation(size: size),
            SizedBox(height: 10),
            TitleWithNothing(title: "Product"),
            CategoryFooter(),
          ],
        ),
      ),
    );
  }
}

_categoryUpdateInsideLoaded(
    BuildContext context, CategoryUpdateInsideLoaded state) {
  int cateId;
  var userDetailState = BlocProvider.of<CategoryDetailBloc>(context).state;
  if (userDetailState is CategoryDetailLoaded) {
    cateId = userDetailState.category.categoryId;
  }
  BlocProvider.of<CategoryDetailBloc>(context)
      .add(CategoryDetailFetchEvent(cateId));
  Navigator.pop(context);
}

_categoryUpdateInsideError(
    BuildContext context, CategoryUpdateInsideError state) {
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

_categoryChangeStatusDialog(BuildContext context, int statusId) {
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
              int categoryId;
              var state = BlocProvider.of<CategoryDetailBloc>(context).state;
              if (state is CategoryDetailLoaded) {
                categoryId = state.category.categoryId;
              }
              BlocProvider.of<CategoryUpdateInsideBloc>(context)
                  .add(CategoryChangeStatus(categoryId, statusId));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_categoryInactive(BuildContext context, int statusId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change to Inative'),
        content: Text('The status will change to Inactive, are you sure?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              int categoryId;
              var state = BlocProvider.of<CategoryDetailBloc>(context).state;
              if (state is CategoryDetailLoaded) {
                categoryId = state.category.categoryId;
              }
              BlocProvider.of<CategoryUpdateInsideBloc>(context)
                  .add(CategoryChangeStatus(categoryId, statusId));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class CategoryMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          // BlocProvider.of<CategoryUpdateBloc>(context)
          //     .add(CategoryUpdateInitialEvent());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCategoryUpdateInformation()));
          break;
        case 'Change to Inactive':
          _categoryInactive(context, StatusIntBase.Inactive);
          break;
        case 'Change to Active':
          _categoryChangeStatusDialog(context, StatusIntBase.Active);
          break;
      }
    }

    return BlocBuilder<CategoryDetailBloc, CategoryDetailState>(
      builder: (context, state) {
        if (state is CategoryDetailLoaded) {
          if (state.category.statusName == StatusStringBase.Inactive) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {'Update Information', 'Change to Active'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.category.statusName == StatusStringBase.Active) {
            if (state.products == null || state.products.isEmpty) {
              return PopupMenuButton<String>(
                onSelected: _handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Update Information', 'Change to Inactive'}
                      .map((String choice) {
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
                  return {'Update Information'}.map((String choice) {
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

class CategoryDetailInformation extends StatelessWidget {
  final Size size;
  CategoryDetailInformation({this.size});
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

class CategoryFooter extends StatelessWidget {
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
                                  builder: (context) => ScreenProductDetail()),
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
