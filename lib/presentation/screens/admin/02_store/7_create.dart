import 'dart:io';
import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenStoreCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Create Store'),
      body: BlocListener<StoreCreateBloc, StoreCreateState>(
        listener: (context, state) {
          if (state is StoreCreateLoaded) {
            _storeCreateLoaded(context, state);
          } else if (state is StoreCreateError) {
            _storeCreateError(context, state);
          } else if (state is StoreCreateLoading) {
            loadingCommon(context);
          } else if (state is StoreDuplicatedName) {
            Navigator.pop(context);
          }
        },
        child: MyScrollView(
          listWidget: [StoreCreateForm()],
        ),
      ),
    );
  }
}

_storeCreateLoaded(BuildContext context, StoreCreateLoaded state) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => ScreenStore()),
    ModalRoute.withName('/'),
  );
  BlocProvider.of<StoreCreateBloc>(context).add(StoreCreateInitialEvent());
  BlocProvider.of<StoreBloc>(context).add(StoreFetchEvent(
    searchValue: "",
    searchField: "",
    fetchNext: 100,
    pageNum: 0,
    statusId: 0,
    cityId: 0,
  ));
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_storeCreateError(BuildContext context, StoreCreateError state) {
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
              Navigator.pop(context);
            },
            child: const Text('Back'),
          ),
        ],
      );
    },
  );
}

class StoreCreateForm extends StatefulWidget {
  @override
  StoreCreateFormState createState() {
    return StoreCreateFormState();
  }
}

class StoreCreateFormState extends State<StoreCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _storeName = TextEditingController();
  final _address = TextEditingController();
  final _districtId = TextEditingController();
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
                      "Store Image :",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: kTextColor,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
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
                StoreTextField(
                  hintText: "Store Name",
                  controller: _storeName,
                ),
                BlocBuilder<StoreCreateBloc, StoreCreateState>(
                  builder: (context, state) {
                    if (state is StoreDuplicatedName) {
                      return DuplicateField(state.message);
                    }
                    return Text("");
                  },
                ),
                SizedBox(height: 15.0),
                StoreTextField(
                  hintText: "Address",
                  controller: _address,
                ),
                SizedBox(height: 15.0),
                StaticDropDown(
                  controller: _districtId,
                  defaultCity: "Ho Chi Minh",
                  defaultDistrict: "District 1",
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Create",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Store _store = new Store(
                        storeName: _storeName.text,
                        imageUrl: "",
                        address: _address.text,
                        districtId: int.parse(_districtId.text),
                      );
                      BlocProvider.of<StoreCreateBloc>(context)
                          .add(StoreCreateSubmitEvent(_store, _image));
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
        print('tao thay roi ' + pickedFile.path.toString());
      } else {
        print('No image selected.');
      }
    });
  }
}
