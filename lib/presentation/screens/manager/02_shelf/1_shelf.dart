import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Shelf'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ScreenShelfSearch()));
            },
          )
        ],
      ),
      drawer: ManagerNavigator(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenShelfCreate()));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Stack(
        children: [
          ShelfHeader('List Shelf'),
          BlocBuilder<ShelfBloc, ShelfState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ShelfLoaded) {
                return ShelfContent();
              } else if (state is ShelfError) {
                return FailureStateWidget();
              } else if (state is ShelfLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

class ShelfBoldText extends StatelessWidget {
  final String _text;
  ShelfBoldText(this._text);
  @override
  Widget build(BuildContext context) {
    if (_text != null) {
      return Container(
        width: 100,
        child: new Text(
          _text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Color.fromRGBO(69, 75, 102, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }
    return Text("");
  }
}

class ShelfNormalText extends StatelessWidget {
  final String _text;
  ShelfNormalText(this._text);
  @override
  Widget build(BuildContext context) {
    if (this._text != null) {
      return Container(
        padding: EdgeInsets.only(left: 5),
        child: new Text(
          _text,
          style: TextStyle(
            color: Color.fromRGBO(24, 34, 76, 1),
            fontSize: 15,
          ),
        ),
      );
    }
    return Text("");
  }
}

class ShelfHeader extends StatelessWidget {
  final String _text;
  ShelfHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScreenHeaderText(_text),
        Container(
          child: ShelfStatusDropdown(),
          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        )
      ],
    );
  }
}

class ShelfContent extends StatefulWidget {
  @override
  _ShelfContentState createState() => _ShelfContentState();
}

class _ShelfContentState extends State<ShelfContent> {
  @override
  Widget build(BuildContext context) {
    List<Shelf> shelves;
    var state = BlocProvider.of<ShelfBloc>(context).state;
    if (state is ShelfLoaded) {
      shelves = state.shelves;
    }
    Future<Null> _onShelfRefresh(BuildContext context) async {
      BlocProvider.of<ShelfBloc>(context)
          .add(ShelfFetchEvent(StatusIntBase.All));
      setState(() {
        shelves.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onShelfRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<Shelf>>(
          initialData: shelves,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Shelf> shelvesList = snapshot.data;
              return ListView.builder(
                itemCount: shelvesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: ShelfBoldText(shelvesList[index].shelfName),
                    subtitle: ShelfNormalText(
                        shelvesList[index].numberOfStack.toString() +
                            " stacks"),
                    trailing: StatusText(shelvesList[index].statusName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenShelfDetail()),
                      );
                      BlocProvider.of<ShelfDetailBloc>(context).add(
                          ShelfDetailFetchEvent(shelvesList[index].shelfId));
                      BlocProvider.of<StackBloc>(context)
                          .add(StackFetchEvent(shelvesList[index].shelfId));
                    },
                  );
                },
              );
            } else {
              return NoRecordWidget();
            }
          },
        ),
      ),
    );
  }
}

class ShelfStatusDropdown extends StatefulWidget {
  @override
  State<ShelfStatusDropdown> createState() => ShelfStatusDropdownState();
}

class ShelfStatusDropdownState extends State<ShelfStatusDropdown> {
  String dropdownValue = "All";
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 15,
      iconEnabledColor: Colors.black,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 1,
        color: Colors.black,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        if (newValue == "Active") {
          BlocProvider.of<ShelfBloc>(context)
              .add(ShelfFetchEvent(StatusIntBase.Active));
        } else if (newValue == "Pending") {
          BlocProvider.of<ShelfBloc>(context)
              .add(ShelfFetchEvent(StatusIntBase.Pending));
        } else if (newValue == "Inactive") {
          BlocProvider.of<ShelfBloc>(context)
              .add(ShelfFetchEvent(StatusIntBase.Inactive));
        } else if (newValue == "All") {
          BlocProvider.of<ShelfBloc>(context)
              .add(ShelfFetchEvent(StatusIntBase.All));
        }
      },
      items: <String>['All', 'Active', 'Pending', 'Inactive']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
