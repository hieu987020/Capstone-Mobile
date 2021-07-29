import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenManagerSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ManagerSearchForm(),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //ManagerHeader('List Manager'),
          BlocBuilder<UserSearchBloc, UserSearchState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is UserSearchInitial) {
                return Center(
                  child: Text("search di thang cho"),
                );
              }
              if (state is UserSearchLoaded) {
                return ManagerSearchContent();
              } else if (state is UserSearchError) {
                return FailureStateWidget();
              } else if (state is UserSearchLoading) {
                return LoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }
}

// //! Manager : Search Form
class ManagerSearchForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          child: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
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
              BlocProvider.of<UserSearchBloc>(context)
                  .add(UserEnterSearchEvent(_controller.text));
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }
}

class ManagerSearchContent extends StatefulWidget {
  @override
  _ManagerSearchContentState createState() => _ManagerSearchContentState();
}

class _ManagerSearchContentState extends State<ManagerSearchContent> {
  @override
  Widget build(BuildContext context) {
    List<User> users;
    var state = BlocProvider.of<UserSearchBloc>(context).state;
    if (state is UserSearchLoaded) {
      users = state.users;
    }
    Future<Null> _onUserRefresh(BuildContext context) async {
      BlocProvider.of<UserSearchBloc>(context).add(UserEnterSearchEvent(""));
      setState(() {
        users.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onUserRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<User>>(
          initialData: users,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<User> userLst = snapshot.data;
              return ListView.builder(
                itemCount: userLst.length,
                itemBuilder: (context, index) {
                  return Text("");
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
