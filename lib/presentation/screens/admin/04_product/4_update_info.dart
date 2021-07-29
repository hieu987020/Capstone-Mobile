import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenProductUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Update Information'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
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
        child: ProductUpdateForm(),
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
            onPressed: () => Navigator.pop(context),
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

//! Product Update : Form
class ProductUpdateForm extends StatefulWidget {
  @override
  ProductUpdateFormState createState() {
    return ProductUpdateFormState();
  }
}

//! Product Update : Form View
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
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 3000,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Update Product'),
              ),
              ProductUpdateTextField(
                  '1 - 100 characters', 'Product Name', _productName),
              ProductUpdateTextField(
                  '1 - 250 characters', 'Description', _description),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ProductUploadCancelButton(),
                  ProductUpdateSaveButton(
                    _formKey,
                    product.productId,
                    _productName,
                    _description,
                    product.imageUrl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//! Product Update : Text Field + Validate
class ProductUpdateTextField extends StatelessWidget {
  ProductUpdateTextField(this._validate, this._labelText, this._controller);
  final String _validate;
  final String _labelText;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: TextFormField(
          controller: _controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _labelText,
            contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
          ),
          validator: (value) {
            switch (_labelText) {
              case 'Product Name':
                if (value.length < 2 || value.length > 100) {
                  return _validate;
                }
                break;

              case 'Description':
                if (value.isEmpty) {
                  return _validate;
                }
                break;

              default:
            }
            return null;
          },
        ),
      ),
    );
  }
}

//! Product Update : Save button
class ProductUpdateSaveButton extends StatelessWidget {
  ProductUpdateSaveButton(
    this._formKey,
    this._productId,
    this._productName,
    this._description,
    this._image,
  );
  final _formKey;
  final String _productId;
  final TextEditingController _productName;
  final TextEditingController _description;
  final String _image;
  @override
  Widget build(BuildContext context) {
    ProductUpdateBloc productCreateBloc =
        BlocProvider.of<ProductUpdateBloc>(context);
    return Container(
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Product _product = new Product(
              productId: _productId,
              productName: _productName.text,
              imageUrl: _image,
              description: _description.text,
//              categories: ,
            );
            productCreateBloc.add(ProductUpdateSubmit(_product));
          }
        },
        child: Text('Save'),
      ),
    );
  }
}

//! Product Update : Cancel button
class ProductUploadCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.grey,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
