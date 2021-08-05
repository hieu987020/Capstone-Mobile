import 'dart:io';

import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/data_providers/const_common.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/screens/screens.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ScreenCameraCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CameraCreateBloc>(context).add(CameraCreateInitialEvent());
    return Scaffold(
      appBar: buildNormalAppbar('Create Camera'),
      resizeToAvoidBottomInset: false,
      body: BlocListener<CameraCreateBloc, CameraCreateState>(
        listener: (context, state) {
          if (state is CameraCreateLoaded) {
            _cameraCreateLoaded(context, state);
          } else if (state is CameraCreateError) {
            _cameraCreateError(context, state);
          } else if (state is CameraCreateLoading) {
            loadingCommon(context);
          } else if (state is CameraCreateDuplicatedIPAddress) {
            Navigator.of(context).pop();
          } else if (state is CameraCreateDuplicatedRTSPString) {
            Navigator.of(context).pop();
          }
        },
        child: MyScrollView(
          listWidget: [
            CameraCreateForm(),
          ],
        ),
      ),
    );
  }
}

// ignore: todo
//TODO  Stuff

_cameraCreateLoaded(BuildContext context, CameraCreateLoaded state) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ScreenCamera()),
  );
  BlocProvider.of<CameraBloc>(context).add(CameraFetchEvent(StatusIntBase.All));
  BlocProvider.of<CameraCreateBloc>(context).add(CameraCreateInitialEvent());
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Create Successfully"),
    duration: Duration(milliseconds: 5000),
  ));
}

_cameraCreateError(BuildContext context, CameraCreateError state) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Create Error'),
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

// ignore: todo
//TODO  View

class CameraCreateForm extends StatefulWidget {
  @override
  CameraCreateFormState createState() {
    return CameraCreateFormState();
  }
}

class CameraCreateFormState extends State<CameraCreateForm> {
  final _formKey = GlobalKey<FormState>();
  final _cameraName = TextEditingController();
  final _ipAddress = TextEditingController();
  final _rtspString = TextEditingController();
  final _macAddress = TextEditingController();
  final _type = TextEditingController(text: '1');
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var state = BlocProvider.of<CameraCreateBloc>(context).state;
    if (state is CameraCreateLoading) {
      return LoadingWidget();
    }
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Camera Image :",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: kTextColor,
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: getImage,
                    child: _image == null
                        ? Container(
                            height: 36,
                            width: 100,
                            child: ElevatedButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: kPrimaryColor.withOpacity(0.6),
                              ),
                              onPressed: getImage,
                              child: Icon(
                                Icons.add_a_photo,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                color: kPrimaryColor.withOpacity(0.3),
                              ),
                              child: Container(
                                height: 80,
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              CameraTextField(
                hintText: "Camera Name",
                controller: _cameraName,
              ),
              SizedBox(height: 15.0),
              CameraTextField(
                hintText: "MAC Address",
                controller: _macAddress,
              ),
              SizedBox(height: 15.0),
              CameraTextField(
                hintText: "IP Address",
                controller: _ipAddress,
              ),
              BlocBuilder<CameraCreateBloc, CameraCreateState>(
                builder: (context, state) {
                  if (state is CameraCreateDuplicatedIPAddress) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              CameraTextField(
                hintText: "RTSP String",
                controller: _rtspString,
              ),
              BlocBuilder<CameraCreateBloc, CameraCreateState>(
                builder: (context, state) {
                  if (state is CameraCreateDuplicatedRTSPString) {
                    return DuplicateField(state.message);
                  }
                  return Text("");
                },
              ),
              CameraTypeRatio(controller: _type, defaultValue: 'Hotspot'),
              SizedBox(height: 15.0),
              PrimaryButton(
                text: "Create",
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Camera _camera = new Camera(
                      cameraName: _cameraName.text,
                      imageUrl: "",
                      macAddress: _macAddress.text,
                      ipAddress: _ipAddress.text,
                      rtspString: _rtspString.text,
                      typeDetect: int.parse(_type.text),
                    );
                    BlocProvider.of<CameraCreateBloc>(context)
                        .add(CameraCreateSubmitEvent(_camera, _image));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('tao thay roi ' + pickedFile.path.toString());
      } else {
        print('No image selected.');
      }
    });
  }
}
