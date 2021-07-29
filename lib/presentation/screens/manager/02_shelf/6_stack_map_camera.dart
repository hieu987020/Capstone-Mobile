import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackMapCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Stack add camera'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => ScreenCameraSearch()));
            },
          )
        ],
      ),
      body: BlocListener<StackUpdateInsideBloc, StackUpdateInsideState>(
        listener: (context, state) {
          if (state is StackUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is StackUpdateInsideError) {
            _stackMapCameraError(context, state);
          } else if (state is StackUpdateInsideLoaded) {
            _stackMapCameraLoaded(context);
          }
        },
        child: Stack(
          children: [
            StackMapCameraHeader('List Camera'),
            BlocBuilder<CameraBloc, CameraState>(
              // ignore: missing_return
              builder: (context, state) {
                if (state is CameraLoaded) {
                  return StackMapCameraContentManager();
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
_stackConfirmCamera(BuildContext context, String cameraId) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Choose camera'),
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
              String stackId;
              var state = BlocProvider.of<StackDetailBloc>(context).state;
              if (state is StackDetailLoaded) {
                stackId = state.stack.stackId;
              }
              BlocProvider.of<StackUpdateInsideBloc>(context)
                  .add(StackMapCameraEvent(stackId, cameraId, 1));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

_stackMapCameraLoaded(BuildContext context) {
  Navigator.pop(context);
  Navigator.pop(context);
}

_stackMapCameraError(BuildContext context, StackUpdateInsideError state) {
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

class StackMapCameraContentManager extends StatefulWidget {
  @override
  _StackMapCameraContentManagerState createState() =>
      _StackMapCameraContentManagerState();
}

class _StackMapCameraContentManagerState
    extends State<StackMapCameraContentManager> {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }
    Future<Null> _onCameraRefresh(BuildContext context) async {
      BlocProvider.of<CameraBloc>(context)
          .add(CameraFetchEvent(StatusIntBase.Pending));
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
                      _stackConfirmCamera(context, cameraLst[index].cameraId);
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

class StackMapCameraHeader extends StatelessWidget {
  final String _text;
  StackMapCameraHeader(this._text);
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
