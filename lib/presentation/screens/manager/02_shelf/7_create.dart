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
      appBar: AppBar(
        title: AppBarText('Create Shelf'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[200],
      body: BlocConsumer<ShelfCreateBloc, ShelfCreateState>(
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
        builder: (context, state) {
          return ShelfCreateForm();
        },
        // ShelfCreateForm(),
      ),
    );
  }
}

// ignore: todo
//TODO  Stuff

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

// ignore: todo
//TODO  View

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
    var state = BlocProvider.of<ShelfCreateBloc>(context).state;
    if (state is ShelfCreateLoading) {
      return LoadingWidget();
    }
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Create Shelf'),
              ),
              ShelfCreateTextField(
                  '1 - 100 characters', 'Shelf Name', _shelfName),
              ShelfCreateTextField(
                  '1 - 250 characters', 'Description', _description),
              ShelfCreateTextField('1', 'Number Of Stacks', _numberOfStacks),
              BlocBuilder<ShelfCreateBloc, ShelfCreateState>(
                builder: (context, state) {
                  if (state is ShelfCreateDuplicatedName) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ShelfCreateSubmitButton(
                    this._formKey,
                    this._shelfName,
                    this._description,
                    this._numberOfStacks,
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

class ShelfCreateSubmitButton extends StatelessWidget {
  final _formKey;
  ShelfCreateSubmitButton(
    this._formKey,
    this._shelfName,
    this._description,
    this._numberOfStacks,
  );
  final TextEditingController _shelfName;
  final TextEditingController _description;
  final TextEditingController _numberOfStacks;
  @override
  Widget build(BuildContext context) {
    ShelfCreateBloc shelfCreateBloc = BlocProvider.of<ShelfCreateBloc>(context);
    return Container(
      width: 150,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Shelf _shelf = new Shelf(
              shelfName: _shelfName.text,
              description: _description.text,
              numberOfStack: int.parse(_numberOfStacks.text),
            );
            shelfCreateBloc.add(ShelfCreateSubmitEvent(_shelf));
          }
        },
        child: Text('Submit'),
      ),
    );
  }
}

class ShelfCreateTextField extends StatelessWidget {
  ShelfCreateTextField(this._validate, this._labelText, this._controller);
  final String _validate;
  final String _labelText;
  final TextEditingController _controller;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 0.5,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
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
              case 'Shelf Name':
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
