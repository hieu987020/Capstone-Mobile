import 'dart:io';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenProductCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Create Product'),
      backgroundColor: Colors.grey[200],
      body: BlocListener<ProductCreateBloc, ProductCreateState>(
        listener: (context, state) {
          if (state is ProductCreateLoaded) {
            _productCreateLoaded(context, state);
          } else if (state is ProductCreateError) {
            _productCreateError(context, state);
          }
        },
        child: MyScrollView(
          listWidget: [ProductCreateForm()],
        ),
      ),
    );
  }
}

_productCreateLoaded(BuildContext context, ProductCreateLoaded state) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenProduct()),
  );
  BlocProvider.of<ProductBloc>(context).add(ProductFetchEvent(
    searchValue: "",
    searchField: "",
    fetchNext: 100,
    pageNum: 0,
    categoryId: 0,
    statusId: 0,
  ));
  BlocProvider.of<ProductCreateBloc>(context).add(ProductCreateInitialEvent());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 5000),
  ));
}

_productCreateError(BuildContext context, ProductCreateError state) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Error'),
        content: Text(state.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

class ProductCreateForm extends StatefulWidget {
  @override
  ProductCreateFormState createState() {
    return ProductCreateFormState();
  }
}

class ProductCreateFormState extends State<ProductCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  final _description = TextEditingController();
  final _category = TextEditingController();

  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Product Image :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(width: 20),
                    InkWell(
                      onTap: getImage,
                      child: _image == null
                          ? Container(
                              height: 36,
                              width: 100,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor:
                                      kPrimaryColor.withOpacity(0.6),
                                ),
                                onPressed: getImage,
                                child: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                height: 60.0,
                                width: 60.0,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.3),
                                ),
                                child: Container(
                                  height: 80,
                                  child: Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
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
                PrimaryButton(
                  text: "Create",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Product _product = new Product(
                        productName: _productName.text,
                        imageUrl: "",
                        description: _description.text,
                      );
                      ProductCreateBloc productCreateBloc =
                          BlocProvider.of<ProductCreateBloc>(context);
                      productCreateBloc
                          .add(ProductCreateSubmitEvent(_product, _image));
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

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
}
