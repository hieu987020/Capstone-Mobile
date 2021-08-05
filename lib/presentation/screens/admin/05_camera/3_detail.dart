import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/data_providers.dart';
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
      body: BlocListener<CameraUpdateInsideBloc, CameraUpdateInsideState>(
        listener: (context, state) {
          if (state is CameraUpdateInsideLoading) {
            loadingCommon(context);
          } else if (state is CameraUpdateInsideError) {
            _cameraUpdateInsideError(context, state);
          } else if (state is CameraUpdateInsideLoaded) {
            _cameraUpdateInsideLoaded(context, state);
          }
        },
        child: MyScrollView(
          listWidget: [
            CameraDetailHeader(),
            CameraDetailInformation(size: size),
          ],
        ),
      ),
    );
  }
}

_cameraUpdateInsideLoaded(
    BuildContext context, CameraUpdateInsideLoaded state) {
  String cameraId;
  var userDetailState = BlocProvider.of<CameraDetailBloc>(context).state;
  if (userDetailState is CameraDetailLoaded) {
    cameraId = userDetailState.camera.cameraId;
  }
  BlocProvider.of<CameraDetailBloc>(context)
      .add(CameraDetailFetchEvent(cameraId));
  Navigator.pop(context);
}

_cameraUpdateInsideError(BuildContext context, CameraUpdateInsideError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error Notification'),
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

_cameraChangeStatusDialog(BuildContext context, int statusId) {
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
              String cameraId;
              var state = BlocProvider.of<CameraDetailBloc>(context).state;
              if (state is CameraDetailLoaded) {
                cameraId = state.camera.cameraId;
              }
              BlocProvider.of<CameraUpdateInsideBloc>(context)
                  .add(CameraChangeStatus(cameraId, statusId, null));
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
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
        case 'Change Image':
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ScreenCameraUpdateImage()));
          break;
        case 'Change to Inactive':
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ScreenCameraInactive()));
          break;
        case 'Change to Pending':
          _cameraChangeStatusDialog(context, StatusIntBase.Pending);
          break;
      }
    }

    return BlocBuilder<CameraDetailBloc, CameraDetailState>(
      builder: (context, state) {
        if (state is CameraDetailLoaded) {
          if (state.camera.statusName == StatusStringBase.Pending) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
                  'Change to Inactive'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.camera.statusName == StatusStringBase.Inactive) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
                  'Change to Pending'
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            );
          } else if (state.camera.statusName == StatusStringBase.Active) {
            return PopupMenuButton<String>(
              onSelected: _handleClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Update Information',
                  'Change Image',
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
            return {''}.map((String choice) {
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
                  fieldName: 'Camera Name',
                  fieldValue: camera.cameraName,
                ),
                DetailDivider(size: size),
                (camera.typeDetect == 1)
                    ? DetailFieldContainer(
                        fieldName: 'Type Detect',
                        fieldValue: 'Hotspot',
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
        }
        return LoadingContainer();
      },
    );
  }
}
