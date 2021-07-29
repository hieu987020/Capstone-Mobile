import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Camera Detail'),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          CameraMenu(),
        ],
      ),
      body: DetailView(
        size: size,
        header: CameraDetailHeader(),
        info: CameraDetailInformation(size: size),
        footer: Text(""),
      ),
    );
  }
}

class CameraMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _handleClick(String value) {
      switch (value) {
        case 'Update Information':
          BlocProvider.of<CameraUpdateBloc>(context)
              .add(CameraUpdateInitialEvent());
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCameraUpdateInformation()));
          break;

        case 'Change Avatar':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCameraUpdateImage()));
          break;
      }
    }

    return PopupMenuButton<String>(
      onSelected: _handleClick,
      itemBuilder: (BuildContext context) {
        return {'Update Information', 'Change Avatar'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}

//! Header
class CameraDetailHeader extends StatelessWidget {
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
        }
        return UnmappedStateWidget();
      },
    );
  }
}

//! Information
class CameraDetailInformation extends StatelessWidget {
  final Size size;
  CameraDetailInformation({this.size});
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
                  // prefixIcon: 'assets/icons/fullname.png',
                  fieldName: 'Camera Name',
                  fieldValue: camera.cameraName,
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
                DetailFieldContainer(
                  fieldName: 'Updated time',
                  fieldValue: camera.updatedTime,
                ),
              ],
            ),
          );
        } else if (state is CameraDetailError) {
          return FailureStateWidget();
        }
        return UnmappedStateWidget();
      },
    );
  }
}
