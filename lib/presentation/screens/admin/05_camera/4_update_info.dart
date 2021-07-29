import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenCameraUpdateInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Update Information'),
        backgroundColor: Colors.grey[200],
        iconTheme: IconThemeData(color: Colors.black),
      ),
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
        child: CameraUpdateForm(),
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
            onPressed: () => Navigator.pop(context),
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

//! Camera Update : Form
class CameraUpdateForm extends StatefulWidget {
  @override
  CameraUpdateFormState createState() {
    return CameraUpdateFormState();
  }
}

//! Camera Update : Form View
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
    final TextEditingController _ipAddress =
        TextEditingController(text: camera.ipAddress);
    final TextEditingController _rtspString =
        TextEditingController(text: camera.rtspString);
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 3000,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Update Camera'),
              ),
              CameraUpdateTextField(
                  '1 - 100 characters', 'Camera Name', _cameraName),
              CameraUpdateTextField(
                  '1 - 250 characters', 'IP Address', _ipAddress),
              BlocBuilder<CameraUpdateBloc, CameraUpdateState>(
                builder: (context, state) {
                  if (state is CameraUpdateDuplicatedIPAddress) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              CameraUpdateTextField('1', 'RTSP String', _rtspString),
              BlocBuilder<CameraUpdateBloc, CameraUpdateState>(
                builder: (context, state) {
                  if (state is CameraUpdateDuplicatedRTSPString) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CameraUploadCancelButton(),
                  CameraUpdateSaveButton(
                    _formKey,
                    camera.cameraId,
                    _cameraName,
                    _ipAddress,
                    _rtspString,
                    camera.imageUrl,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//! Camera Update : Text Field + Validate
class CameraUpdateTextField extends StatelessWidget {
  CameraUpdateTextField(this._validate, this._labelText, this._controller);
  final String _validate;
  final String _labelText;
  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topLeft,
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
        child: TextFormField(
          controller: _controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: _labelText,
            contentPadding: EdgeInsets.fromLTRB(5, 0, 10, 0),
          ),
          validator: (value) {
            switch (_labelText) {
              case 'Camera Name':
                if (value.length < 2 || value.length > 100) {
                  return _validate;
                }
                break;
              case 'Address':
                if (value.isEmpty) {
                  return _validate;
                }
                break;

              case 'District':
                if (value.isEmpty) {
                  return _validate;
                }
                break;

              default:
            }
            return null;
          },
        ),
      ),
    );
  }
}

//! Camera Update : Save button
class CameraUpdateSaveButton extends StatelessWidget {
  CameraUpdateSaveButton(
    this._formKey,
    this._cameraId,
    this._cameraName,
    this._ipAddress,
    this._rtspString,
    this._image,
  );
  final _formKey;
  final String _cameraId;
  final TextEditingController _cameraName;
  final TextEditingController _ipAddress;
  final TextEditingController _rtspString;
  final String _image;
  @override
  Widget build(BuildContext context) {
    CameraUpdateBloc cameraCreateBloc =
        BlocProvider.of<CameraUpdateBloc>(context);
    return Container(
      width: 100,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue,
        ),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Camera _camera = new Camera(
              cameraId: _cameraId,
              cameraName: _cameraName.text,
              imageUrl: _image,
              ipAddress: _ipAddress.text,
              rtspString: _rtspString.text,
            );
            cameraCreateBloc.add(CameraUpdateSubmit(_camera));
          }
        },
        child: Text('Save'),
      ),
    );
  }
}

//! Camera Update : Cancel button
class CameraUploadCancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.grey,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
    );
  }
}
