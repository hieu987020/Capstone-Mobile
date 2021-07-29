import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Shelf Detail'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.grey[200],
      body: BlocListener<ShelfUpdateInsideBloc, ShelfUpdateInsideState>(
        listener: (context, state) {
          if (state is ShelfUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is ShelfUpdateInsideError) {
            _shelfUpdateInsideError(context, state);
          } else if (state is ShelfUpdateInsideLoaded) {
            _shelfUpdateInsideLoaded(context);
          }
        },
        child: ShelfDetailView(),
      ),
    );
  }
}

// ignore: todo
//TODO Stuff
_shelfUpdateInsideError(BuildContext context, ShelfUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error notification'),
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

_shelfUpdateInsideLoaded(BuildContext context) {
  String shelfId;
  var state = BlocProvider.of<ShelfDetailBloc>(context).state;
  if (state is ShelfDetailLoaded) {
    shelfId = state.shelf.shelfId;
  }
  BlocProvider.of<ShelfDetailBloc>(context).add(ShelfDetailFetchEvent(shelfId));
  Navigator.pop(context);
}

_removeHotspotCamera(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove hotspot camera'),
        content: Text('Are you sure to remove this camera'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              String shelfId;
              String cameraId;
              var state = BlocProvider.of<ShelfDetailBloc>(context).state;
              if (state is ShelfDetailLoaded) {
                shelfId = state.shelf.shelfId;
                cameraId = state.shelf.camera.first.cameraId;
              }
              BlocProvider.of<ShelfUpdateInsideBloc>(context)
                  .add(ShelfMapCameraEvent(shelfId, cameraId, 2));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

//! View
class ShelfDetailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Null> _onShelfRefresh(BuildContext context) async {
      var state = BlocProvider.of<ShelfDetailBloc>(context).state;
      String shelfId;
      if (state is ShelfDetailLoaded) {
        shelfId = state.shelf.shelfId;
      }
      BlocProvider.of<ShelfDetailBloc>(context)
          .add(ShelfDetailFetchEvent(shelfId));
      BlocProvider.of<StackBloc>(context).add(StackFetchEvent(shelfId));
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onShelfRefresh(context);
      },
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ShelfDetailInformation(),
            HotSpotCameraInside(),
            StackContent(),
          ],
        ),
      ),
    );
  }
}

class ShelfDetailInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoading) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 250,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingWidget(),
                ],
              ),
            ),
          );
        } else if (state is ShelfDetailLoaded) {
          Shelf shelf = state.shelf;
          return ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 250,
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
                MediaQuery.of(context).size.width * 0.025,
              ),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SDBodyTitleText("Shelf " + shelf.shelfName),
                      StatusText(shelf.statusName),
                    ],
                  ),
                  SDBodyFieldnameText("Number of Stacks"),
                  SDBodyContentText(shelf.numberOfStack.toString()),
                  SDBodyFieldnameText("Description"),
                  SDBodyContentText(shelf.description),
                  SDBodyFieldnameText("Created Time"),
                  SDBodyContentText(shelf.createdTime),
                  SDBodyFieldnameText("Updated Time"),
                  SDBodyContentText(shelf.updatedTime),
                ],
              ),
            ),
          );
        } else if (state is ShelfDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class HotSpotCameraInside extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoading) {
          return Container(
            height: 200,
            child: LoadingWidget(),
          );
        } else if (state is ShelfDetailLoaded) {
          if (state.shelf.camera.isEmpty || state.shelf.camera == null) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 50,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText("Add Hotspot Camera"),
                        Container(
                          width: 50,
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.grey[500],
                            ),
                            onPressed: () {
                              BlocProvider.of<CameraBloc>(context)
                                  .add(CameraFetchEvent(StatusIntBase.Pending));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenShelfMapCamera()));
                            },
                            child: Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state.shelf.camera.first != null) {
            Camera camera = state.shelf.camera.first;
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 250,
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                  MediaQuery.of(context).size.width * 0.025,
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SDBodyTitleText(camera.cameraName),
                        HotspotCameraMenu(),
                      ],
                    ),
                    SDBodyFieldnameText("IP Address"),
                    SDBodyContentText(camera.ipAddress ?? "no ip"),
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      height: 100,
                      child: Image.network(camera.imageUrl),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        return UnmappedStateWidget();
      },
    );
  }
}

class StackContent extends StatefulWidget {
  @override
  _StackContentState createState() => _StackContentState();
}

class _StackContentState extends State<StackContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackBloc, StackState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is StackLoading) {
          return Container(
            height: 500,
            child: LoadingWidget(),
          );
        } else if (state is StackError) {
          return Text("Error");
        } else if (state is StackLoaded) {
          var stacks = state.stacks;
          return FutureBuilder<List<StackModel>>(
            initialData: stacks,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<StackModel> stacksList = snapshot.data;
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: stacksList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: StackBoldText("Position " +
                            stacksList[index].position.toString()),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            stacksList[index].product == null
                                ? StackNormalText("No Product")
                                : StackNormalText(
                                    stacksList[index].product.productName),
                            stacksList[index].camera == null
                                ? StackNormalText("No Camera")
                                : StackNormalText(
                                    stacksList[index].camera.cameraName),
                          ],
                        ),
                        trailing: StatusText(stacksList[index].statusName),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenStackDetail()),
                          );
                          BlocProvider.of<StackDetailBloc>(context).add(
                              StackDetailFetchEvent(stacksList[index].stackId));
                        },
                      );
                    },
                  ),
                );
              } else if (snapshot.data == null) {
                return NoRecordWidget();
              } else if (snapshot.hasError) {
                return Text("No Record: ${snapshot.error}");
              }
              return LoadingWidget();
            },
          );
        }
      },
    );
  }
}

class HotspotCameraMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'View Detail':
          String cameraId;
          var state = BlocProvider.of<ShelfDetailBloc>(context).state;
          if (state is ShelfDetailLoaded) {
            cameraId = state.shelf.camera.first.cameraId;
          }
          BlocProvider.of<CameraDetailBloc>(context)
              .add(CameraDetailFetchEvent(cameraId));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCameraDetailManager()));
          break;

        case 'Remove':
          _removeHotspotCamera(context);
          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: _handleClick,
      itemBuilder: (BuildContext context) {
        return {'View Detail', 'Remove'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

class StackBoldText extends StatelessWidget {
  final String _text;
  StackBoldText(this._text);
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

class StackNormalText extends StatelessWidget {
  final String _text;
  StackNormalText(this._text);
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
