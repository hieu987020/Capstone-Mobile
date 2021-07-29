import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfMapCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Shelf add camera'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ScreenCameraSearch()));
            },
          )
        ],
      ),
      body: BlocListener<ShelfUpdateInsideBloc, ShelfUpdateInsideState>(
        listener: (context, state) {
          if (state is ShelfUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is ShelfUpdateInsideError) {
            _shelfMapCameraError(context, state);
          } else if (state is ShelfUpdateInsideLoaded) {
            _shelfMapCameraLoaded(context);
          }
        },
        child: Stack(
          children: [
            ShelfMapCameraHeader('List Camera'),
            BlocBuilder<CameraBloc, CameraState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is CameraLoaded) {
                  return ShelfMapCameraContentManager();
                } else if (state is CameraError) {
                  return FailureStateWidget();
                } else if (state is CameraLoading) {
                  return LoadingWidget();
                }
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

// ignore: todo
//TODO Stuff
_shelfConfirmCamera(BuildContext context, String cameraId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose Camera'),
        content: Text('Are you sure to add this camera?'),
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
                  .add(ShelfMapCameraEvent(shelfId, cameraId, 1));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_shelfMapCameraLoaded(BuildContext context) {
  // BlocProvider.of<ShelfUpdateInsideBloc>(context)
  //     .add(ShelfUpdateInsideInitialEvent());
  Navigator.pop(context);
  Navigator.pop(context);
}

_shelfMapCameraError(BuildContext context, ShelfUpdateInsideError state) {
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

class ShelfMapCameraContentManager extends StatefulWidget {
  @override
  _ShelfMapCameraContentManagerState createState() =>
      _ShelfMapCameraContentManagerState();
}

class _ShelfMapCameraContentManagerState
    extends State<ShelfMapCameraContentManager> {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }
    Future<Null> _onCameraRefresh(BuildContext context) async {
      BlocProvider.of<CameraBloc>(context)
          .add(CameraFetchEvent(StatusIntBase.All));
      setState(() {
        cameras.clear();
      });
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onCameraRefresh(context);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 60),
        child: FutureBuilder<List<Camera>>(
          initialData: cameras,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Camera> cameraLst = snapshot.data;
              return ListView.builder(
                itemCount: cameraLst.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(cameraLst[index].imageUrl),
                      backgroundColor: Colors.white,
                    ),
                    title: Text(cameraLst[index].cameraName),
                    subtitle: Text(cameraLst[index].ipAddress),
                    trailing: StatusText(cameraLst[index].statusName),
                    onTap: () {
                      _shelfConfirmCamera(context, cameraLst[index].cameraId);
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

class ShelfMapCameraHeader extends StatelessWidget {
  final String _text;
  ShelfMapCameraHeader(this._text);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ScreenHeaderText(_text),
      ],
    );
  }
}
