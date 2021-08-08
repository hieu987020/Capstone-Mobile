import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackMapCamera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Choose Emotion Camera'),
      body: MyScrollView(
        listWidget: [
          SizedBox(height: 10),
          TitleWithNothing(
            title: 'Camera',
          ),
          BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state is CameraLoaded) {
                return EmotionCameraContent();
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
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

class EmotionCameraContent extends StatelessWidget {
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
                    sub: "Emotion Camera",
                    status: "Pending",
                    navigationField: cameraLst[index].cameraId,
                    onTap: () {
                      _stackConfirmCamera(context, cameraLst[index].cameraId);
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
