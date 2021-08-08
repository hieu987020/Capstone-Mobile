import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraUpdateImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Change Image'),
      body: BlocListener<CameraUpdateImageBloc, CameraUpdateImageState>(
        listener: (context, state) {
          if (state is CameraUpdateImageLoading) {
            loadingCommon(context);
          } else if (state is CameraUpdateImageError) {
            _cameraUpdateImageError(context, state);
          } else if (state is CameraUpdateImageLoaded) {
            _cameraUpdateImageLoaded(context, state);
          }
        },
        child: UpdateImage(model: 'camera'),
      ),
    );
  }
}

_cameraUpdateImageError(BuildContext context, CameraUpdateImageError state) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Update Error'),
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

_cameraUpdateImageLoaded(BuildContext context, CameraUpdateImageLoaded state) {
  String cameraId;
  var cameraDetailState = BlocProvider.of<CameraDetailBloc>(context).state;
  if (cameraDetailState is CameraDetailLoaded) {
    cameraId = cameraDetailState.camera.cameraId;
  }
  BlocProvider.of<CameraDetailBloc>(context)
      .add(CameraDetailFetchEvent(cameraId));
  Navigator.pop(context);
  Navigator.pop(context);
}
