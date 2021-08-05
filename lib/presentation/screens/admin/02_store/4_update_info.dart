import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Update Store'),
      body: BlocListener<StoreUpdateBloc, StoreUpdateState>(
        listener: (context, state) {
          if (state is StoreUpdateLoaded) {
            _storeUpdateLoaded(context, state);
          } else if (state is StoreUpdateError) {
            _storeUpdateError(context, state);
          } else if (state is StoreUpdateLoading) {
            loadingCommon(context);
          }
        },
        child: MyScrollView(listWidget: [StoreUpdateForm()]),
      ),
    );
  }
}

_storeUpdateLoaded(BuildContext context, StoreUpdateLoaded state) {
  String storeId;
  var storeDetailState = BlocProvider.of<StoreDetailBloc>(context).state;
  if (storeDetailState is StoreDetailLoaded) {
    storeId = storeDetailState.store.storeId;
  }
  BlocProvider.of<StoreDetailBloc>(context).add(StoreDetailFetchEvent(storeId));
  Navigator.pop(context);
  Navigator.pop(context);
}

_storeUpdateError(BuildContext context, StoreUpdateError state) {
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

//! Store Update : Form
class StoreUpdateForm extends StatefulWidget {
  @override
  StoreUpdateFormState createState() {
    return StoreUpdateFormState();
  }
}

//! Store Update : Form View
class StoreUpdateFormState extends State<StoreUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<StoreDetailBloc>(context).state;
    Store store;
    if (state is StoreDetailLoaded) {
      store = state.store;
    }
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _storeName =
        TextEditingController(text: store.storeName);
    final TextEditingController _address =
        TextEditingController(text: store.address);
    final TextEditingController _districtId =
        TextEditingController(text: store.districtId.toString());
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 15.0),
                StoreTextField(
                  hintText: "Store Name",
                  controller: _storeName,
                ),
                SizedBox(height: 15.0),
                StoreTextField(
                  hintText: "Address",
                  controller: _address,
                ),
                SizedBox(height: 15.0),
                StaticDropDown(
                  controller: _districtId,
                  defaultCity: store.cityName,
                  defaultDistrict: store.districtName,
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Save",
                  onPressed: () {
                    StoreUpdateBloc storeCreateBloc =
                        BlocProvider.of<StoreUpdateBloc>(context);
                    if (_formKey.currentState.validate()) {
                      Store _store = new Store(
                        storeId: store.storeId,
                        storeName: _storeName.text,
                        imageUrl: store.imageUrl,
                        address: _address.text,
                        districtId: int.parse(_districtId.text),
                      );
                      storeCreateBloc.add(StoreUpdateSubmit(_store));
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
