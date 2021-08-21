import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildNormalAppbar('Update Camera'),
      body: BlocListener<CameraUpdateBloc, CameraUpdateState>(
        listener: (context, state) {
          if (state is CameraUpdateLoaded) {
            _cameraUpdateLoaded(context, state);
          } else if (state is CameraUpdateError) {
            _cameraUpdateError(context, state);
          } else if (state is CameraUpdateLoading) {
            _cameraUpdateLoading(context);
          } else if (state is CameraUpdateDuplicatedIPAddress) {
            Navigator.of(context).pop();
          } else if (state is CameraUpdateDuplicatedRTSPString) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [CameraUpdateForm()],
        ),
      ),
    );
  }
}

_cameraUpdateLoaded(BuildContext context, CameraUpdateLoaded state) {
  String cameraId;
  var cameraDetailState = BlocProvider.of<CameraDetailBloc>(context).state;
  if (cameraDetailState is CameraDetailLoaded) {
    cameraId = cameraDetailState.camera.cameraId;
  }
  BlocProvider.of<CameraDetailBloc>(context)
      .add(CameraDetailFetchEvent(cameraId));
  Navigator.pop(context);
  Navigator.pop(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Update Successfully"),
    duration: Duration(milliseconds: 2000),
  ));
}

_cameraUpdateError(BuildContext context, CameraUpdateError state) {
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

_cameraUpdateLoading(BuildContext context) {
  showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return LoadingDialog();
    },
  );
}

class CameraUpdateForm extends StatefulWidget {
  @override
  CameraUpdateFormState createState() {
    return CameraUpdateFormState();
  }
}

class CameraUpdateFormState extends State<CameraUpdateForm> {
  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<CameraDetailBloc>(context).state;
    Camera camera;
    if (state is CameraDetailLoaded) {
      camera = state.camera;
    }

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _cameraName =
        TextEditingController(text: camera.cameraName);
    final TextEditingController _macAddress =
        TextEditingController(text: camera.macAddress);
    final TextEditingController _ipAddress =
        TextEditingController(text: camera.ipAddress);
    final TextEditingController _rtspString =
        TextEditingController(text: camera.rtspString);

    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 15.0),
              ProductTextField(
                hintText: "Camera Name",
                controller: _cameraName,
              ),
              SizedBox(height: 15.0),
              ProductTextField(
                hintText: "MAC Address",
                controller: _macAddress,
              ),
              SizedBox(height: 15.0),
              ProductTextField(
                hintText: "IP Address",
                controller: _ipAddress,
              ),
              BlocBuilder<CameraUpdateBloc, CameraUpdateState>(
                builder: (context, state) {
                  if (state is CameraUpdateDuplicatedIPAddress) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              ProductTextField(
                hintText: "RTSP String",
                controller: _rtspString,
              ),
              BlocBuilder<CameraUpdateBloc, CameraUpdateState>(
                builder: (context, state) {
                  if (state is CameraUpdateDuplicatedRTSPString) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              SizedBox(height: 15.0),
              PrimaryButton(
                text: "Save",
                onPressed: () {
                  CameraUpdateBloc cameraUpdateBloc =
                      BlocProvider.of<CameraUpdateBloc>(context);
                  if (_formKey.currentState.validate()) {
                    Camera _camera = new Camera(
                      cameraId: camera.cameraId,
                      cameraName: _cameraName.text,
                      imageUrl: camera.imageUrl,
                      macAddress: _macAddress.text,
                      ipAddress: _ipAddress.text,
                      rtspString: _rtspString.text,
                    );
                    cameraUpdateBloc.add(CameraUpdateSubmit(_camera));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
