import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraDetailManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildNormalAppbar('Camera Detail'),
      body: MyScrollView(
        listWidget: [
          CameraDetailHeaderM(),
          CameraDetailInformationM(size: size),
        ],
      ),
    );
  }
}

class CameraDetailHeaderM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraDetailBloc, CameraDetailState>(
      builder: (context, state) {
        if (state is CameraDetailLoading) {
          return LoadingContainer();
        } else if (state is CameraDetailLoaded) {
          var camera = state.camera;
          return DetailHeaderContainer(
            imageURL: camera.imageUrl,
            title: camera.cameraName,
            status: camera.statusName,
          );
        } else if (state is CameraDetailError) {
          return FailureStateWidget();
        } else if (state is CameraDetailNoPermission) {
          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //   content: Text("Create Successfully"),
          //   duration: Duration(milliseconds: 2000),
          // ));
          return NoPermission();
        }
        return LoadingContainer();
      },
    );
  }
}

class CameraDetailInformationM extends StatelessWidget {
  final Size size;
  CameraDetailInformationM({this.size});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraDetailBloc, CameraDetailState>(
      builder: (context, state) {
        if (state is CameraDetailLoading) {
          return LoadingContainer();
        } else if (state is CameraDetailLoaded) {
          var camera = state.camera;
          return Container(
            constraints: BoxConstraints(minWidth: 500, maxWidth: 800),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailFieldContainer(
                  fieldName: 'Camera Name',
                  fieldValue: camera.cameraName,
                ),
                DetailDivider(size: size),
                (camera.typeDetect == 1)
                    ? DetailFieldContainer(
                        fieldName: 'Type Detect',
                        fieldValue: 'Counting',
                      )
                    : DetailFieldContainer(
                        fieldName: 'Type Detect',
                        fieldValue: 'Emotion',
                      ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'MAC Address',
                  fieldValue: camera.macAddress,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'IP Address',
                  fieldValue: camera.ipAddress,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'RTSP String',
                  fieldValue: camera.rtspString,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Created time',
                  fieldValue: camera.createdTime,
                ),
                DetailDivider(size: size),
                DetailFieldContainer(
                  fieldName: 'Updated time',
                  fieldValue: camera.updatedTime,
                ),
                (camera.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailDivider(size: size),
                (camera.reasonInactive == null)
                    ? SizedBox(height: 0)
                    : DetailFieldContainer(
                        fieldName: 'Reason Inactive',
                        fieldValue: camera.reasonInactive,
                      ),
                DetailDivider(size: size),
              ],
            ),
          );
        } else if (state is CameraDetailError) {
          return FailureStateWidget();
        } else if (state is CameraDetailNoPermission) {
          return Text("");
        }
        return LoadingContainer();
      },
    );
  }
}
