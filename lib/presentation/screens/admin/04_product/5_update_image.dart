import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductUpdateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Change Image'),
      body: BlocListener<ProductUpdateImageBloc, ProductUpdateImageState>(
        listener: (context, state) {
          if (state is ProductUpdateImageLoading) {
            loadingCommon(context);
          } else if (state is ProductUpdateImageError) {
            _productUpdateImageError(context, state);
          } else if (state is ProductUpdateImageLoaded) {
            _productUpdateImageLoaded(context, state);
          }
        },
        child: UpdateImage(
          model: "product",
        ),
      ),
    );
  }
}

_productUpdateImageError(BuildContext context, ProductUpdateImageError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

_productUpdateImageLoaded(
    BuildContext context, ProductUpdateImageLoaded state) {
  String productId;
  var productDetailState = BlocProvider.of<ProductDetailBloc>(context).state;
  if (productDetailState is ProductDetailLoaded) {
    productId = productDetailState.product.productId;
  }
  BlocProvider.of<ProductDetailBloc>(context)
      .add(ProductDetailFetchEvent(productId));
  Navigator.pop(context);
  Navigator.pop(context);
}
