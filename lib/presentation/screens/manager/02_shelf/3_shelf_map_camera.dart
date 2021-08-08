import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfMapCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Choose Counter Camera'),
      body: MyScrollView(
        listWidget: [
          SizedBox(height: 10),
          TitleWithNothing(
            title: 'Camera',
          ),
          BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state is CameraLoaded) {
                return CounterCameraContent();
              } else if (state is CameraError) {
                return FailureStateWidget();
              } else if (state is CameraLoading) {
                return LoadingWidget();
              }
              return LoadingWidget();
            },
          ),
        ],
      ),
    );
  }
}

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
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class CounterCameraContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Camera> cameras;
    var state = BlocProvider.of<CameraBloc>(context).state;
    if (state is CameraLoaded) {
      cameras = state.cameras;
    }

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: FutureBuilder<List<Camera>>(
          initialData: cameras,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Camera> cameraLst = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: cameraLst.length,
                itemBuilder: (context, index) {
                  return ObjectListInkWell(
                    model: 'camera',
                    imageURL: cameraLst[index].imageUrl,
                    title: cameraLst[index].cameraName,
                    sub: "Counter Camera",
                    status: "Pending",
                    navigationField: cameraLst[index].cameraId,
                    onTap: () {
                      _shelfConfirmCamera(context, cameraLst[index].cameraId);
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
