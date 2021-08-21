import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildNormalAppbar('Update Shelf'),
      body: BlocListener<ShelfUpdateBloc, ShelfUpdateState>(
        listener: (context, state) {
          if (state is ShelfUpdateLoaded) {
            _shelfUpdateLoaded(context, state);
          } else if (state is ShelfUpdateError) {
            _shelfUpdateError(context, state);
          } else if (state is ShelfUpdateLoading) {
            loadingCommon(context);
          }
        },
        child: MyScrollView(listWidget: [ShelfUpdateForm()]),
      ),
    );
  }
}

_shelfUpdateLoaded(BuildContext context, ShelfUpdateLoaded state) {
  String shelfId;
  var shelfDetailState = BlocProvider.of<ShelfDetailBloc>(context).state;
  if (shelfDetailState is ShelfDetailLoaded) {
    shelfId = shelfDetailState.shelf.shelfId;
  }
  BlocProvider.of<ShelfDetailBloc>(context).add(ShelfDetailFetchEvent(shelfId));
  Navigator.pop(context);
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Update Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_shelfUpdateError(BuildContext context, ShelfUpdateError state) {
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

class ShelfUpdateForm extends StatefulWidget {
  @override
  ShelfUpdateFormState createState() {
    return ShelfUpdateFormState();
  }
}

class ShelfUpdateFormState extends State<ShelfUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<ShelfDetailBloc>(context).state;
    Shelf shelf;
    if (state is ShelfDetailLoaded) {
      shelf = state.shelf;
    }
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _shelfName =
        TextEditingController(text: shelf.shelfName);
    final TextEditingController _description =
        TextEditingController(text: shelf.description);

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
                SizedBox(height: 10.0),
                ShelfTextField(
                  hintText: "Shelf Name",
                  controller: _shelfName,
                ),
                SizedBox(height: 15.0),
                ShelfTextField(
                  hintText: "Description",
                  controller: _description,
                ),
                SizedBox(height: 15.0),
                PrimaryButton(
                  text: "Save",
                  onPressed: () {
                    ShelfUpdateBloc shelfCreateBloc =
                        BlocProvider.of<ShelfUpdateBloc>(context);
                    if (_formKey.currentState.validate()) {
                      Shelf _shelf = new Shelf(
                        shelfId: shelf.shelfId,
                        shelfName: _shelfName.text,
                        description: _description.text,
                      );
                      shelfCreateBloc.add(ShelfUpdateSubmit(_shelf));
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
