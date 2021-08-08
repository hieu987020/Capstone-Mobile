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
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => outApp(context),
      child: Scaffold(
        appBar: buildAppBar(),
        drawer: ManagerNavigator(
          size: size,
          selectedIndex: 'Shelf',
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ScreenShelfCreate()));
          },
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        body: MyScrollView(
          listWidget: [
            HeaderWithSearchBox(
              size: size,
              title: "Hi Manager",
            ),
            TitleWithMoreBtn(
              title: 'Shelf',
              model: 'shelf',
              defaultStatus: StatusStringBase.All,
            ),
            BlocBuilder<ShelfBloc, ShelfState>(
              builder: (context, state) {
                if (state is ShelfLoaded) {
                  return ShelfContent();
                } else if (state is ShelfError) {
                  return FailureStateWidget();
                } else if (state is ShelfLoading) {
                  return LoadingWidget();
                }
                return LoadingWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class ShelfContent extends StatefulWidget {
//   @override
//   _ShelfContentState createState() => _ShelfContentState();
// }

// class _ShelfContentState extends State<ShelfContent> {
//   @override
//   Widget build(BuildContext context) {
//     List<Shelf> shelves;
//     var state = BlocProvider.of<ShelfBloc>(context).state;
//     if (state is ShelfLoaded) {
//       shelves = state.shelves;
//     }
//     Future<Null> _onShelfRefresh(BuildContext context) async {
//       BlocProvider.of<ShelfBloc>(context)
//           .add(ShelfFetchEvent(StatusIntBase.All));
//       setState(() {
//         shelves.clear();
//       });
//     }

//     return RefreshIndicator(
//       onRefresh: () async {
//         _onShelfRefresh(context);
//       },
//       child: Container(
//         margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
//         child: FutureBuilder<List<Shelf>>(
//           initialData: shelves,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Shelf> shelvesList = snapshot.data;
//               return ListView.builder(
//                 itemCount: shelvesList.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: ShelfBoldText(shelvesList[index].shelfName),
//                     subtitle: ShelfNormalText(
//                         shelvesList[index].numberOfStack.toString() +
//                             " stacks"),
//                     trailing: StatusText(shelvesList[index].statusName),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => ScreenShelfDetail()),
//                       );
//                       BlocProvider.of<ShelfDetailBloc>(context).add(
//                           ShelfDetailFetchEvent(shelvesList[index].shelfId));
//                       BlocProvider.of<StackBloc>(context)
//                           .add(StackFetchEvent(shelvesList[index].shelfId));
//                     },
//                   );
//                 },
//               );
//             } else {
//               return NoRecordWidget();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ShelfStatusDropdown extends StatefulWidget {
//   @override
//   State<ShelfStatusDropdown> createState() => ShelfStatusDropdownState();
// }

// class ShelfStatusDropdownState extends State<ShelfStatusDropdown> {
//   String dropdownValue = "All";
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       iconSize: 15,
//       iconEnabledColor: Colors.black,
//       elevation: 16,
//       style: const TextStyle(color: Colors.black),
//       underline: Container(
//         height: 1,
//         color: Colors.black,
//       ),
//       onChanged: (String newValue) {
//         setState(() {
//           dropdownValue = newValue;
//         });
//         if (newValue == "Active") {
//           BlocProvider.of<ShelfBloc>(context)
//               .add(ShelfFetchEvent(StatusIntBase.Active));
//         } else if (newValue == "Pending") {
//           BlocProvider.of<ShelfBloc>(context)
//               .add(ShelfFetchEvent(StatusIntBase.Pending));
//         } else if (newValue == "Inactive") {
//           BlocProvider.of<ShelfBloc>(context)
//               .add(ShelfFetchEvent(StatusIntBase.Inactive));
//         } else if (newValue == "All") {
//           BlocProvider.of<ShelfBloc>(context)
//               .add(ShelfFetchEvent(StatusIntBase.All));
//         }
//       },
//       items: <String>['All', 'Active', 'Pending', 'Inactive']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

class ShelfContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Shelf> shelves;
    var state = BlocProvider.of<ShelfBloc>(context).state;
    if (state is ShelfLoaded) {
      shelves = state.shelves;
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Shelf>>(
          initialData: shelves,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Shelf> lst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: lst.length,
                itemBuilder: (context, index) {
                  return ShelfListInkWell(
                    model: 'manager',
                    title: lst[index].shelfName,
                    sub: lst[index].description ?? "",
                    three: "Number stacks: " +
                            lst[index].numberOfStack.toString() ??
                        "",
                    status: lst[index].statusName,
                    navigationField: lst[index].shelfId,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScreenShelfDetail()),
                      );
                      BlocProvider.of<ShelfDetailBloc>(context)
                          .add(ShelfDetailFetchEvent(lst[index].shelfId));
                      BlocProvider.of<StackBloc>(context)
                          .add(StackFetchEvent(lst[index].shelfId));
                    },
                  );
                },
              );
            } else if (snapshot.data == null) {
              return NoRecordWidget();
            } else if (snapshot.hasError) {
              return ErrorRecordWidget();
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }
}
