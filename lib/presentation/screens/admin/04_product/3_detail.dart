import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
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
      body: MyScrollView(
        listWidget: [
          ProductDetailHeader(),
          ProductDetailInformation(size: size),
        ],
      ),
    );
  }
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
          break;
        case 'Change To Active':
          break;
      }
    }

    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoaded) {
          if (state.product.statusName == StatusStringBase.Active) {
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
          } else if (state.product.statusName == StatusStringBase.Inactive) {
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
