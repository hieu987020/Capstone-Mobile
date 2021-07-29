import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackMapProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Stack add product'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ScreenStackSearch()));
            },
          )
        ],
      ),
      body: BlocListener<StackUpdateInsideBloc, StackUpdateInsideState>(
        listener: (context, state) {
          if (state is StackUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is StackUpdateInsideError) {
            _stackMapProductError(context, state);
          } else if (state is StackUpdateInsideLoaded) {
            _stackMapProductLoaded(context);
          }
        },
        child: Stack(
          children: [
            StackMapProductHeader('List Product'),
            BlocBuilder<ProductBloc, ProductState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return StackMapProductContentManager();
                } else if (state is ProductError) {
                  return FailureStateWidget();
                } else if (state is ProductLoading) {
                  return LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

// ignore: todo
//TODO Stuff
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
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_stackMapProductLoaded(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

_stackMapProductError(BuildContext context, StackUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error notification'),
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

class StackMapProductContentManager extends StatefulWidget {
  @override
  _StackMapProductContentManagerState createState() =>
      _StackMapProductContentManagerState();
}

class _StackMapProductContentManagerState
    extends State<StackMapProductContentManager> {
  @override
  Widget build(BuildContext context) {
    List<Product> products;
    var state = BlocProvider.of<ProductBloc>(context).state;
    if (state is ProductLoaded) {
      products = state.products;
    }
    Future<Null> _onStackRefresh(BuildContext context) async {
      BlocProvider.of<ProductBloc>(context)
          .add(ProductFetchEvent(StatusIntBase.Active));
      setState(() {
        products.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onStackRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<Product>>(
          initialData: products,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Product> productLst = snapshot.data;
              return ListView.builder(
                itemCount: productLst.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(productLst[index].imageUrl),
                      backgroundColor: Colors.white,
                    ),
                    title: StackBoldText(productLst[index].productName),
                    subtitle: StackNormalText(productLst[index].description),
                    trailing: StatusText(productLst[index].statusName),
                    onTap: () {
                      _stackConfirmProduct(
                          context, productLst[index].productId);
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

class StackMapProductHeader extends StatelessWidget {
  final String _text;
  StackMapProductHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScreenHeaderText(_text),
      ],
    );
  }
}
