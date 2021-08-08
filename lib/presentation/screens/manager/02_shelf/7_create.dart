import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShelfCreateBloc>(context).add(ShelfCreateInitialEvent());
    return Scaffold(
      appBar: buildNormalAppbar('Create Shelf'),
      resizeToAvoidBottomInset: false,
      body: BlocListener<ShelfCreateBloc, ShelfCreateState>(
        listener: (context, state) {
          if (state is ShelfCreateLoaded) {
            _shelfCreateLoaded(context, state);
          } else if (state is ShelfCreateError) {
            _shelfCreateError(context, state);
          } else if (state is ShelfCreateLoading) {
            loadingCommon(context);
          } else if (state is ShelfCreateDuplicatedName) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [
            ShelfCreateForm(),
          ],
        ),
      ),
    );
  }
}

_shelfCreateLoaded(BuildContext context, ShelfCreateLoaded state) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenShelf()),
  );
  BlocProvider.of<ShelfBloc>(context).add(ShelfFetchEvent(StatusIntBase.All));
  BlocProvider.of<ShelfCreateBloc>(context).add(ShelfCreateInitialEvent());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 5000),
  ));
}

_shelfCreateError(BuildContext context, ShelfCreateError state) {
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

class ShelfCreateForm extends StatefulWidget {
  @override
  ShelfCreateFormState createState() {
    return ShelfCreateFormState();
  }
}

class ShelfCreateFormState extends State<ShelfCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _shelfName = TextEditingController();
  final _description = TextEditingController();
  final _numberOfStacks = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
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
              // ShelfTextField(
              //   hintText: "Number of stacks",
              //   controller: _numberOfStacks,
              // ),
              SizedBox(height: 15.0),
              Text(
                "Number of stacks",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.0),
              StackNum(defaultValue: '1', controller: _numberOfStacks),
              SizedBox(height: 15.0),
              PrimaryButton(
                text: "Create",
                onPressed: () {
                  ShelfCreateBloc shelfCreateBloc =
                      BlocProvider.of<ShelfCreateBloc>(context);
                  if (_formKey.currentState.validate()) {
                    Shelf _shelf = new Shelf(
                      shelfName: _shelfName.text,
                      description: _description.text,
                      numberOfStack: int.parse(_numberOfStacks.text),
                    );
                    shelfCreateBloc.add(ShelfCreateSubmitEvent(_shelf));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
