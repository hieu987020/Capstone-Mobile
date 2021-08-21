import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfDetail extends StatefulWidget {
  final String shelfId;
  ScreenShelfDetail({@required this.shelfId});
  @override
  _ScreenShelfDetailState createState() => _ScreenShelfDetailState(shelfId);
}

class _ScreenShelfDetailState extends State<ScreenShelfDetail> {
  final String shelfId;
  _ScreenShelfDetailState(this.shelfId);

  Future<Null> _onRefresh(BuildContext context) async {
    callApi();
  }

  callApi() {
    BlocProvider.of<ShelfDetailBloc>(context)
        .add(ShelfDetailFetchEvent(shelfId));
    BlocProvider.of<StackBloc>(context).add(StackFetchEvent(shelfId));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async => _onRefresh(context),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarText('Shelf Detail'),
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            ShelfMenu(),
          ],
        ),
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
          child: MyScrollView(
            listWidget: [
              SizedBox(height: 10),
              TitleWithNothing(title: "About"),
              ShelfDetailInformation(size: size),
              SizedBox(height: 10),
              TitleWithNothing(title: "Counting Camera"),
              CountingCameraInside1(),
              CountingCameraInside2(),
              TitleWithNothing(title: "Stack"),
              StackContent(),
            ],
          ),
        ),
      ),
    );
  }
}

_shelfUpdateInsideError(BuildContext context, ShelfUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('App Message'),
        content: Text(state.message ?? "Null"),
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
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Update Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_removeCountingCamera(
    BuildContext context, String cameraId, String cameraName) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Remove Counting camera'),
        content: Text('Are you sure to remove camera $cameraName'),
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
              var state = BlocProvider.of<ShelfDetailBloc>(context).state;
              if (state is ShelfDetailLoaded) {
                shelfId = state.shelf.shelfId;
                // cameraId = state.shelf.camera.first.cameraId;
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

_shelfChangeStatusDialog(BuildContext context, int statusId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Change to Pending'),
        content: Text('The status will change to Pending, are you sure?'),
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
              var state = BlocProvider.of<ShelfDetailBloc>(context).state;
              if (state is ShelfDetailLoaded) {
                shelfId = state.shelf.shelfId;
              }
              BlocProvider.of<ShelfUpdateInsideBloc>(context)
                  .add(ShelfChangeStatus(shelfId, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class ShelfDetailInformation extends StatelessWidget {
  final Size size;
  ShelfDetailInformation({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoading) {
          return LoadingContainer();
        } else if (state is ShelfDetailLoaded) {
          var shelf = state.shelf;
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Container(
              constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailFieldContainerStatus(
                    fieldName: 'Status',
                    fieldValue: shelf.statusName,
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Shelf Name',
                    fieldValue: shelf.shelfName,
                  ),
                  DetailDivider(size: size),
                  DescriptionFieldContainer(
                    fieldName: 'Description',
                    fieldValue: shelf.description,
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Created time',
                    fieldValue: shelf.createdTime,
                  ),
                  DetailDivider(size: size),
                  DetailFieldContainer(
                    fieldName: 'Updated time',
                    fieldValue: shelf.updatedTime,
                  ),
                  (shelf.reasonInactive == null)
                      ? SizedBox(height: 0)
                      : DetailDivider(size: size),
                  (shelf.reasonInactive == null)
                      ? SizedBox(height: 0)
                      : DetailFieldContainer(
                          fieldName: 'Reason Inactive',
                          fieldValue: shelf.reasonInactive,
                        ),
                  DetailDivider(size: size),
                ],
              ),
            ),
          );
        } else if (state is ShelfDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}

class CountingCameraInside1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoading) {
          return LoadingContainer();
        } else if (state is ShelfDetailLoaded) {
          var shelf = state.shelf;
          if (shelf.camera == null || shelf.camera.isEmpty) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                ("Add Counting Camera"),
                                style: TextStyle(
                                  color: Color.fromRGBO(69, 75, 102, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor.withOpacity(0.6),
                              ),
                              onPressed: () {
                                BlocProvider.of<CameraBloc>(context)
                                    .add(CameraAvailableEvent(
                                  cameraName: "",
                                  pageNum: 0,
                                  fetchNext: 100,
                                  typeId: 1,
                                ));
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
              ),
            );
          } else {
            Camera camera = shelf.camera[0];
            return Padding(
              padding: EdgeInsets.only(
                left: kDefaultPadding / 2,
                right: kDefaultPadding / 2,
                top: kDefaultPadding / 2,
              ),
              child: CountingListInkWell(
                model: 'camera',
                imageURL: camera.imageUrl,
                title: camera.cameraName,
                sub: "MAC Address: " + camera.macAddress,
                status: "Active",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenCameraDetailManager()),
                  );
                  BlocProvider.of<CameraDetailBloc>(context)
                      .add(CameraDetailFetchEvent(camera.cameraId));
                },
                onRemove: () {
                  _removeCountingCamera(
                      context, camera.cameraId, camera.cameraName);
                },
              ),
            );
          }
        } else if (state is ShelfDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}

class CountingCameraInside2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoading) {
          return LoadingContainer();
        } else if (state is ShelfDetailLoaded) {
          var shelf = state.shelf;
          if (shelf.camera == null ||
              shelf.camera.isEmpty ||
              shelf.camera.length != 2) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Padding(
                padding: EdgeInsets.only(
                    left: kDefaultPadding / 2,
                    right: kDefaultPadding / 2,
                    bottom: kDefaultPadding / 2),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              child: Text(
                                ("Add Counting Camera"),
                                style: TextStyle(
                                  color: Color.fromRGBO(69, 75, 102, 1),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor.withOpacity(0.6),
                              ),
                              onPressed: () {
                                BlocProvider.of<CameraBloc>(context)
                                    .add(CameraAvailableEvent(
                                  cameraName: "",
                                  pageNum: 0,
                                  fetchNext: 100,
                                  typeId: 1,
                                ));
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
              ),
            );
          } else if (shelf.camera.length == 2) {
            Camera camera = shelf.camera[1];
            return Padding(
              padding: EdgeInsets.only(
                  left: kDefaultPadding / 2, right: kDefaultPadding / 2),
              child: CountingListInkWell(
                model: 'camera',
                imageURL: camera.imageUrl,
                title: camera.cameraName,
                sub: "MAC Address: " + camera.macAddress,
                status: "Active",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScreenCameraDetailManager()),
                  );
                  BlocProvider.of<CameraDetailBloc>(context)
                      .add(CameraDetailFetchEvent(camera.cameraId));
                },
                onRemove: () {
                  _removeCountingCamera(
                      context, camera.cameraId, camera.cameraName);
                },
              ),
            );
          }
        } else if (state is ShelfDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}

class StackContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StackBloc, StackState>(
      builder: (context, state) {
        if (state is StackLoading) {
          return LoadingContainer();
        } else if (state is StackLoaded) {
          List<StackModel> stacks = state.stacks;
          return Flexible(
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: FutureBuilder<List<StackModel>>(
                initialData: stacks,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<StackModel> lst = snapshot.data;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: lst.length,
                      itemBuilder: (context, index) {
                        return StackListInkWell(
                          model: 'manager',
                          title: "Position " + lst[index].position.toString(),
                          sub: lst[index].product == null
                              ? "Product: -"
                              : "Product: " + lst[index].product.productName,
                          three: lst[index].camera == null
                              ? "Emotion Camera: -"
                              : "Emotion Camera: " +
                                  lst[index].camera.cameraName,
                          status: lst[index].statusName,
                          navigationField: lst[index].stackId,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScreenStackDetail(
                                        stackId: lst[index].stackId,
                                      )),
                            );
                            BlocProvider.of<StackDetailBloc>(context)
                                .add(StackDetailFetchEvent(lst[index].stackId));
                          },
                        );
                      },
                    );
                  } else if (snapshot.data == null) {
                    return NoRecordWidget();
                  } else if (snapshot.hasError) {
                    return ErrorRecordWidget();
                  }
                  return LoadingContainer();
                },
              ),
            ),
          );
        } else if (state is ShelfDetailError) {
          return FailureStateWidget();
        }
        return LoadingContainer();
      },
    );
  }
}

class ShelfMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenShelfUpdateInformation()));
          break;
        case 'Change to Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenShelfInactive()));
          break;
        case 'Change to Pending':
          _shelfChangeStatusDialog(context, StatusIntBase.Pending);
          break;
      }
    }

    return BlocBuilder<ShelfDetailBloc, ShelfDetailState>(
      builder: (context, state) {
        if (state is ShelfDetailLoaded) {
          if (state.shelf.statusName.contains(StatusStringBase.Pending)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change to Inactive',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.shelf.statusName
              .contains(StatusStringBase.Inactive)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change to Pending',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.shelf.statusName.contains(StatusStringBase.Active)) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          }
        }
        return PopupMenuButton<String>(
          onSelected: _handleClick,
          itemBuilder: (BuildContext context) {
            return {""}.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        );
      },
    );
  }
}
