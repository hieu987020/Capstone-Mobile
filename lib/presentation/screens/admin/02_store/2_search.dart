import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStoreSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StoreSearchForm(),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BlocBuilder<StoreBloc, StoreState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is StoreLoaded) {
                return StoreSearchContent();
              } else if (state is StoreError) {
                return FailureStateWidget();
              } else if (state is StoreLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}

// //! Store : Search Form
class StoreSearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    //final String _labelText = "Search by storename";
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              // labelText: _labelText,
              contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
            ),
          ),
        ),
        Container(
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
              BlocProvider.of<StoreBloc>(context)
                  .add(StoreSearchEvent(_controller.text));
              print("========================\n");
              print(_controller.text);
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }
}

class StoreSearchContent extends StatefulWidget {
  @override
  _StoreSearchContentState createState() => _StoreSearchContentState();
}

class _StoreSearchContentState extends State<StoreSearchContent> {
  @override
  Widget build(BuildContext context) {
    List<Store> stores;
    var state = BlocProvider.of<StoreBloc>(context).state;
    if (state is StoreLoaded) {
      stores = state.stores;
    }
    Future<Null> _onStoreRefresh(BuildContext context) async {
      BlocProvider.of<StoreBloc>(context)
          .add(StoreFetchEvent(StatusIntBase.All));
      setState(() {
        stores.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onStoreRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<Store>>(
          initialData: stores,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Store> storeLst = snapshot.data;
              return ListView.builder(
                itemCount: storeLst.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(storeLst[index].imageUrl),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(storeLst[index].storeName),
                    subtitle: Text(storeLst[index].storeName),
                    trailing: StatusText(storeLst[index].statusName),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenStoreDetail()),
                      );
                      BlocProvider.of<StoreDetailBloc>(context).add(
                          StoreDetailFetchEvent(storeLst[index].storeName));
                    },
                  );
                },
              );
            } else if (snapshot.data == null) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return Text("No Record: ${snapshot.error}");
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
