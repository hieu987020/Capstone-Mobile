import 'package:capstone/business_logic/bloc/bloc.dart';
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
      body: DetailView(
        size: size,
        header: ProductDetailHeader(),
        info: ProductDetailInformation(size: size),
        footer: Text(""),
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
      }
    }

    return PopupMenuButton<String>(
      onSelected: _handleClick,
      itemBuilder: (BuildContext context) {
        return {'Update Information', 'Change Image'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

//! Header
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

//! Information
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
