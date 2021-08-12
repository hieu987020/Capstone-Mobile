import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenStackMapCamera extends StatefulWidget {
  @override
  _ScreenStackMapCameraState createState() => _ScreenStackMapCameraState();
}

class _ScreenStackMapCameraState extends State<ScreenStackMapCamera> {
  TextEditingController _valueSearch = TextEditingController(text: "");
  // TextEditingController _statusId = TextEditingController(text: "");
  String searchField = "storeName";
  // String selectedValueStatus = "";

  @override
  void initState() {
    // selectedValueStatus = 'All';
    _valueSearch.value = TextEditingValue(text: '');
    // _statusId.value = TextEditingValue(text: '0');
    super.initState();
  }

  Future<Null> _onRefresh(BuildContext context) async {
    callApi();
  }

  callApi() {
    BlocProvider.of<CameraBloc>(context).add(CameraAvailableEvent(
      cameraName: _valueSearch.text,
      pageNum: 0,
      fetchNext: 100,
      typeId: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _onRefresh(context),
      child: Scaffold(
        appBar: buildNormalAppbar('Choose Emotion Camera'),
        body: MyScrollView(
          listWidget: [
            SearchBox(
              onSubmitted: (value) {
                setState(() {
                  _valueSearch.value = TextEditingValue(text: value);
                });
                FocusScope.of(context).requestFocus(new FocusNode());
                callApi();
              },
              onChanged: (value) {
                setState(() {
                  _valueSearch.value = TextEditingValue(text: value);
                });
              },
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                callApi();
              },
            ),
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
