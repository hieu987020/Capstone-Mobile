import 'package:capstone/business_logic/bloc/bloc.dart';
import 'package:capstone/data/models/models.dart';
import 'package:capstone/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenShelfMapCamera extends StatefulWidget {
  @override
  _ScreenShelfMapCameraState createState() => _ScreenShelfMapCameraState();
}

class _ScreenShelfMapCameraState extends State<ScreenShelfMapCamera> {
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
      typeId: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNormalAppbar('Choose Counting Camera'),
      body: RefreshIndicator(
        onRefresh: () async => _onRefresh(context),
        child: MyScrollView(
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
                  return CountingCameraContent();
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

class CountingCameraContent extends StatelessWidget {
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
                    sub: "Counting Camera",
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
