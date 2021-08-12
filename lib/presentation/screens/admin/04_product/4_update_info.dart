import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Update product'),
      body: BlocListener<ProductUpdateBloc, ProductUpdateState>(
        listener: (context, state) {
          if (state is ProductUpdateLoaded) {
            _productUpdateLoaded(context, state);
          } else if (state is ProductUpdateError) {
            _productUpdateError(context, state);
          } else if (state is ProductUpdateLoading) {
            _productUpdateLoading(context);
          }
        },
        child: MyScrollView(
          listWidget: [
            ProductUpdateForm(),
          ],
        ),
      ),
    );
  }
}

_productUpdateLoaded(BuildContext context, ProductUpdateLoaded state) {
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

_productUpdateError(BuildContext context, ProductUpdateError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
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

_productUpdateLoading(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );
}

class ProductUpdateForm extends StatefulWidget {
  @override
  ProductUpdateFormState createState() {
    return ProductUpdateFormState();
  }
}

class ProductUpdateFormState extends State<ProductUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<ProductDetailBloc>(context).state;
    Product product;
    if (state is ProductDetailLoaded) {
      product = state.product;
    }
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _productName =
        TextEditingController(text: product.productName);
    final TextEditingController _description =
        TextEditingController(text: product.description);
    final TextEditingController _category = TextEditingController(text: "Ipod");
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 15.0),
                ProductTextField(
                  hintText: "Product Name",
                  controller: _productName,
                ),
                SizedBox(height: 15.0),
                ProductTextField(
                  hintText: "Description",
                  controller: _description,
                ),
                SizedBox(height: 15.0),
                ProductTextField(
                  hintText: "Category",
                  controller: _category,
                ),
                SizedBox(height: 15.0),
                // ProductTextField(
                //   hintText: "Category",
                //   controller: _category,
                // ),
                // SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Save",
                  onPressed: () {
                    ProductUpdateBloc productCreateBloc =
                        BlocProvider.of<ProductUpdateBloc>(context);
                    if (_formKey.currentState.validate()) {
                      Product _product = new Product(
                        productId: product.productId,
                        productName: _productName.text,
                        imageUrl: product.imageUrl,
                        description: _description.text,
                        categories: product.categories,
                      );
                      productCreateBloc.add(ProductUpdateSubmit(_product));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
