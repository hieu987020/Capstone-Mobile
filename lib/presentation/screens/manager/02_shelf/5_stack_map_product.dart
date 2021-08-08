import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackMapProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Choose Product'),
      body: MyScrollView(
        listWidget: [
          SizedBox(height: 10),
          TitleWithNothing(
            title: 'Product',
          ),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoaded) {
                return ProductMapContent();
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
    );
  }
}

_stackConfirmProduct(BuildContext context, String productId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose product'),
        content: Text('Are you sure to add this product?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String stackId;
              var state = BlocProvider.of<StackDetailBloc>(context).state;
              if (state is StackDetailLoaded) {
                stackId = state.stack.stackId;
              }
              BlocProvider.of<StackUpdateInsideBloc>(context)
                  .add(StackMapProductEvent(stackId, productId, 1));
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class ProductMapContent extends StatelessWidget {
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
              List<Product> lst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'camera',
                    imageURL: lst[index].imageUrl,
                    title: lst[index].productName,
                    sub: lst[index].description,
                    status: lst[index].statusName,
                    navigationField: lst[index].productId,
                    onTap: () {
                      _stackConfirmProduct(context, lst[index].productId);
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
